%FEAST加显著性检验

clear;clc;
load('Red_EyeDatabase.mat');

%FEAST选择个数
n = 20;
%第一个等级个数
FirstNumber = 10;
%第二个等级个数
SecondNumber = n - FirstNumber;
%K-fold检验
opts = '-s 0 -t 2 -c 1 -g 0.25';    
nfold = 10;

%数据打乱
[Data_Random Label_Random] = RandomData(Data, Label);

%FEAST选择20个，离散方法用高级离散
[selectedIndices,~] = FeatureSelect( Data,Label,n,1);

%FEAST结果生成
[Data_Selected] =  DataSelect(Data,selectedIndices);

%显著性检验FEAST的结果
p = SignificanceTest(Data, Label);
%根据FEAST结果选出要用的P
[Data_Selected_P] =  DataSelect_P(p,selectedIndices);

%FEAST结果与P值合并，分成两个等级
First = [selectedIndices(1:FirstNumber), Data_Selected_P(1:FirstNumber)];
Second = [selectedIndices(FirstNumber+1:n), Data_Selected_P(FirstNumber+1:n)];
old = First;

%在FEAST排序下，两个等级的P值比较，若第二等级的P值比第一等级P值小，则替换并检验
% [Data, ~] = pretreatment(Data, Data)
%First由后往前
for x = FirstNumber:-1:1

    %First原有准确率生成
    [Data_First] =  DataSelect(Data,First(:,1));
    First_acc = libsvmtrain(Label, Data_First, sprintf('%s -v %d -q',opts,nfold));
  
    %Second由前往后
    Change_acc = zeros(SecondNumber,2);
    replace_i = 0;
    for y = 1:1:SecondNumber
        %若第二等级的P值比第一等级P值小，则替换并检验
        if First(x,2) > Second(y,2)
            replace_i = replace_i+1;
            %SVM打分计算，若替换后高于替换前，则替换
            [NewFirst NewSecond] = replace(First, x,Second, y);
            
            %计算替换后，First的准确率
            [Data_Change] =  DataSelect(Data,NewFirst(:,1));
            Change_acc(replace_i, 1) = libsvmtrain(Label, Data_Change, sprintf('%s -v %d -q',opts,nfold));
            %记录下对应Second的位置
            Change_acc(replace_i, 2) = y;
        end
    end 
    %原acc排序，acc从高往低与原有acc比较
    Change_acc = sortrows(Change_acc,1);
    for k = SecondNumber:-1:1
        %一旦发现acc更高，则替换
        if Change_acc(k,1) > First_acc
            [First Second] = replace(First, x,Second, Change_acc(k,2));
            First_acc = Change_acc(k,1);
            c = 'change'
        end
    end 
        
a = '********'
end

[Data_First] =  DataSelect(Data,First(:,1));
First_acc = libsvmtrain(Label, Data_First, sprintf('%s -v %d -q',opts,nfold))

First - old

%与直接FEAST的结果一样