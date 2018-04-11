%不要Kfold，只是研究RF概率
clc;clear;
load('Cluster_Straight.mat');
load('Cluster_Right.mat');
load('Cluster_Left.mat');
TexNnumber = 10;
k = 1;
number = 124;
TreeNumber = 20;
compare = zeros(1,2);

DataLabel = [clu_Left ClusterData_Left;clu_Straight ClusterData_Straight;...
    clu_Right ClusterData_Right];
[m n] = size(ClusterData_Left);
DataLabel_Random = DataLabel(randperm(size(DataLabel,1)),:);
Label = DataLabel_Random(:,1);
Data = DataLabel_Random(:,2:n+1);

SVM = [];
AccuracyRF = zeros(1,k);
    
for i = 1:1:TexNnumber
    
    %计算新方法准确率(RF)
    RFmodel = TreeBagger(TreeNumber , Data, Label);
    [~,RFScores] = predict(RFmodel, Data);

    %排序
    [a, b ] = sort(RFScores');
    [Row, Column] = size(RFScores);
    max_pro = [a(Column,:)', a(Column-1,:)', a(Column-2,:)', a(Column-3,:)', a(Column-4,:)'];
    max_index = [b(Column,:)', b(Column-1,:)', b(Column-2,:)', b(Column-3,:)', b(Column-4,:)'];

    %最大概率三种模式
    patern = RFmodel.ClassNames(max_index);
    %result_patern为对应预测意图：-1,0,1
    [result_patern patern_pro] = RFPatern(max_pro,patern,5);
    AccuracyRF(1,i) = Accuracy_New(Label,result_patern)*100/number;
    
end

AccuracyRF_mean  = mean(AccuracyRF);
SVM = [SVM;AccuracyRF_mean];
NewSVM = mean(SVM)
compare(1,1) = NewSVM;


%%

Label = LabelRecovery(Label);

SVM = [];
AccuracyRF = zeros(1,k);
for i = 1:1:TexNnumber
    
    
    Factor = TreeBagger(TreeNumber, Data, Label);
    [RF_Predict,RFScores] = predict(Factor, Data); 
    AccuracyRF(1,i) = RF_Accuracy(Label,RF_Predict)*100/number;
    
end

AccuracyRF_mean  = mean(AccuracyRF);
SVM = [SVM;AccuracyRF_mean];
TraditionalRF = mean(SVM)
compare(1,2) = TraditionalRF ;



