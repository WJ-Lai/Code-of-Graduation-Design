%SVM输出概率
clc;clear;

load('Cluster_Straight.mat');
All = 61;
TestNumber = 10;
TrainNumber = All - TestNumber;


ClusterDataLabel = [clu_Straight ClusterData_Straight];
ClusterDataLabel_Random = ClusterDataLabel(randperm(size(ClusterDataLabel,1)),:);

%label和data分离，取训练集和测试集
%取1-TrainNumber行为训练集
train_label = ClusterDataLabel_Random(1:TrainNumber,1);
train_data = ClusterDataLabel_Random(1:TrainNumber,2:11);

%取TrainNumber+1-All行为测试集
test_label = ClusterDataLabel_Random(TrainNumber+1:All,1);
test_data = ClusterDataLabel_Random(TrainNumber+1:All,2:11);


model = libsvmtrain(train_label ,train_data , '-c 1 -g 0.03 -b 1');
[predict_label, accuracy, scores]  = libsvmpredict(test_label,test_data, model, '-b 1'); 

[a, b ] = sort(scores');
[Row, Column] = size(scores);
max_pro = [a(Column,:)', a(Column-1,:)', a(Column-2,:)'];
max_index = [b(Column,:)', b(Column-1,:)', b(Column-2,:)'];
patern = model.Label(max_index);
[result_patern patern_pro] = SVMPatern(max_pro,patern,3);
Accuracy_New(test_label,result_patern)*100/TestNumber;