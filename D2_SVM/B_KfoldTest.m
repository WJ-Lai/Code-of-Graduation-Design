%²âÊÔKfoldº¯Êý
clc;clear;
load('Cluster_Straight.mat');
load('Cluster_Right.mat');
load('Cluster_Left.mat');
TexNnumber = 5;
K = 10;
g = '0.9';
TreeNumber = 30;

DataLabel = [clu_Left ClusterData_Left;clu_Straight ClusterData_Straight;...
    clu_Right ClusterData_Right];
[m n] = size(ClusterData_Left);
DataLabel_Random = DataLabel(randperm(size(DataLabel,1)),:);
Label = DataLabel_Random(:,1);
Data = DataLabel_Random(:,2:n+1);

SVM = [];
RF = [];
for i = 1:1:TexNnumber
    [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = NewKfold(K, Label, Data, g,TreeNumber);
    SVM = [SVM;AccuracySVM_mean];
    RF = [RF;AccuracyRF_mean];
end

NewSVM = mean(SVM);
NewRF = mean(RF);

%%

Label = LabelRecovery(Label);

SVM = [];
RF = [];
for l = 1:1:TexNnumber
    [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = Kfold(K, Label, Data, g,TreeNumber);
    SVM = [SVM;AccuracySVM_mean];
    RF = [RF;AccuracyRF_mean];
end

TraditionalSVM = mean(SVM)
TraditionalRF = mean(RF)

NewSVM
NewRF

