%研究SVM改善过拟合
clc;clear;
load('Cluster_Straight.mat');
load('Cluster_Right.mat');
load('Cluster_Left.mat');
TexNnumber = 2;
K = 5;

g_ini = 0.01;
g_finlVal = 2;
g_goin = 0.08;
g_bujin = g_finlVal/g_goin;
g = g_ini:g_goin:g_finlVal;

c_ini = 0;
c_finlVal = 0.5;
c_goin = 0.5;
c_bujin = c_finlVal/c_goin;
c = c_ini:c_goin:c_finlVal;

TreeNumber = 30;

New = zeros(TexNnumber,g_bujin);
Tradition = zeros(TexNnumber,g_bujin);
    
NewAcc = zeros(c_bujin,g_bujin);
OldAcc = zeros(c_bujin,g_bujin);
for i_c = 1:1:c_bujin

        DataLabel = [clu_Left ClusterData_Left;clu_Straight ClusterData_Straight;...
            clu_Right ClusterData_Right];
        [m n] = size(ClusterData_Left);
        DataLabel_Random = DataLabel(randperm(size(DataLabel,1)),:);
        Label = DataLabel_Random(:,1);
        Data = DataLabel_Random(:,2:n+1);
        
        %新方法        
        for i_g = 1:1:g_bujin
            [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = NewKfold(K, Label, Data,c(),g,TreeNumber);
            compare(1,1) = AccuracySVM_mean;
        end
        
        %传统方法
        for i_g = 1:1:g_bujin
            Label = LabelRecovery(Label)
            [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = Kfold(K, Label, Data,c,g,TreeNumber);
            compare(2,1) = AccuracySVM_mean;
        end
        
 end

% 
% figure();
% NewMean = mean(New);
% TraditionMean = mean(Tradition);
% x = g_ini:g_goin:g_finlVal;
% plot(x,NewMean,'o-',x,TraditionMean,'*-');
% set(gca,'XTick',[0:0.5:g_finlVal])
% set(gca,'YTick',[0:5:100])
% legend('新SVM','传统SVM');
% xlabel('gamma系数','fontsize',15)
% ylabel('准确率（%）','fontsize',15)
% title('gamma系数对准确率的影响','fontsize',18);