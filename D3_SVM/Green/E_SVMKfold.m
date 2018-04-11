%研究SVM改善过拟合
clc;clear;
load('Cluster_Straight.mat');
load('Cluster_Right.mat');
load('Cluster_Left.mat');
TexNnumber = 3;
K = 10;
ini = 0.01;
finlVal = 2;
goin = 0.08;
bujin = finlVal/goin;
TreeNumber = 30;
New = zeros(TexNnumber,bujin);
Tradition = zeros(TexNnumber,bujin);
for t = 1:1:TexNnumber
    compare = zeros(2,bujin);

    DataLabel = [clu_Left ClusterData_Left;clu_Straight ClusterData_Straight;...
        clu_Right ClusterData_Right];
    [m n] = size(ClusterData_Left);
    DataLabel_Random = DataLabel(randperm(size(DataLabel,1)),:);
    Label = DataLabel_Random(:,1);
    Data = DataLabel_Random(:,2:n+1);


    i = 1;
    for g = ini:goin:finlVal

        [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = NewKfold(K, Label, Data,g,TreeNumber);
        compare(1,i) = AccuracySVM_mean;
        i = i+1;

    end  

    %传统方法
    Label = LabelRecovery(Label)
    i = 1;
    for g = ini:goin:finlVal

        [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = Kfold(K, Label, Data, g,TreeNumber);
        compare(2,i) = AccuracySVM_mean;
        i = i+1;
    end
   
    New(t,:) = compare(1,:);
    Tradition(t,:) = compare(2,:);
    
end

figure();
NewMean = mean(New);
TraditionMean = mean(Tradition);
x = ini:goin:finlVal;
plot(x,NewMean,'o-',x,TraditionMean,'*-');
set(gca,'XTick',[0:0.5:finlVal])
set(gca,'YTick',[0:5:100])
legend('新SVM','传统SVM');
xlabel('gamma系数','fontsize',15)
ylabel('准确率（%）','fontsize',15)
title('gamma系数对准确率的影响','fontsize',18);