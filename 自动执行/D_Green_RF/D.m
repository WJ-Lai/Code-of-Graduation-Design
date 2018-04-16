%研究SVM改善过拟合
function d = D();
clc;clear;
load('Cluster_Straight.mat');
load('Cluster_Right.mat');
load('Cluster_Left.mat');
TexNnumber = 10;
K = 10;
ini = 5
finlVal = 100;
goin = 5;
bujin = finlVal/goin;
g = 0.3;
c = 2;
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
    for TreeNumber = ini:goin:finlVal

        [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = NewKfold(K, Label, Data, c,g,TreeNumber);
        compare(1,i) = AccuracyRF_mean;
        i = i+1;

    end  

    %传统方法
    Label = LabelRecovery(Label);
    i = 1;
    for TreeNumber = ini:goin:finlVal

        [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = Kfold(K, Label, Data, c,g,TreeNumber);
        compare(2,i) = AccuracyRF_mean;
        i = i+1;
    end
   
    New(t,:) = compare(1,:);
    Tradition(t,:) = compare(2,:);

    clear DataLabel;
    load('Cluster_Straight.mat');
    load('Cluster_Right.mat');
    load('Cluster_Left.mat');
end

figure();
NewMean = mean(New);
TraditionMean = mean(Tradition);
x = ini:goin:finlVal;
plot(x,NewMean,'o-',x,TraditionMean,'*-');
set(gca,'XTick',[ini:goin:finlVal])
set(gca,'YTick',[0:5:100])
legend('新RF','传统RF');
xlabel('树数量','fontsize',15)
ylabel('准确率（%）','fontsize',15)
title('树数量对准确率的影响','fontsize',18);
save data
end