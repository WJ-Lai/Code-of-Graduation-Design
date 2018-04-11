%研究SVM改善过拟合
clc;clear;
load('Cluster_Straight.mat');
load('Cluster_Right.mat');
load('Cluster_Left.mat');
TexNnumber = 3;
K = 10;

g_ini = 0.01;
g_finlVal = 0.19;
g_goin = 0.02;
g_bujin = (g_finlVal-g_ini)/g_goin +1;
g = g_ini:g_goin:g_finlVal;

c_ini = 0.25;
c_finlVal = 2.5;
c_goin = 0.25;
c_bujin = (c_finlVal-c_ini)/c_goin +1;
c = c_ini:c_goin:c_finlVal;

TreeNumber = 30;

New = zeros(c_bujin,g_bujin);
Tradition = zeros(c_bujin,g_bujin);
    
NewAcc = zeros(c_bujin,g_bujin);
OldAcc = zeros(c_bujin,g_bujin);
compare = zeros(2,g_bujin)
for t = 1:1:TexNnumber
    for i_c = 1:1:c_bujin

            DataLabel = [clu_Left ClusterData_Left;clu_Straight ClusterData_Straight;...
                clu_Right ClusterData_Right];
            [m n] = size(ClusterData_Left);
            DataLabel_Random = DataLabel(randperm(size(DataLabel,1)),:);
            Label = DataLabel_Random(:,1);
            Data = DataLabel_Random(:,2:n+1);

            %新方法        
            for i_g = 1:1:g_bujin
                [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = NewKfold(K, Label, Data,1,g(1,i_g),TreeNumber);
                NewAcc(i_c,i_g) = NewAcc(i_c,i_g) + AccuracySVM_mean;
                compare(1,i_g) = AccuracySVM_mean;
             
            end

            %传统方法
            for i_g = 1:1:g_bujin
                Label = LabelRecovery(Label);
                [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = Kfold(K, Label, Data,1,g(1,i_g),TreeNumber);
                OldAcc(i_c,i_g) = OldAcc(i_c,i_g) + AccuracySVM_mean;
                compare(2,i_g) = AccuracySVM_mean;
            end
    end
    
    New(t,:) = compare(1,:);
    Tradition(t,:) = compare(2,:);
end

NewAcc = NewAcc/TexNnumber;
OldAcc = OldAcc/TexNnumber;

figure();
[C1,h1] = contour(c,g,NewAcc);
clabel(C1,h1);
figure();
[C2,h2] = contour(c,g,OldAcc)
clabel(C2,h2);

figure();
NewMean = mean(New);
TraditionMean = mean(Tradition);
x = g_ini:g_goin:g_finlVal;
plot(x,NewMean,'o-',x,TraditionMean,'*-');
set(gca,'XTick',[g_ini:g_goin:g_finlVal])
set(gca,'YTick',[0:5:100])
legend('新SVM','传统SVM');
xlabel('gammar','fontsize',15)
ylabel('准确率（%）','fontsize',15)
title('gammar系数对准确率的影响','fontsize',18);