%不要Kfold，只是研究SVM概率
clc;clear;
load('Cluster_Straight.mat');
load('Cluster_Right.mat');
load('Cluster_Left.mat');
TexNnumber = 1;
k = 1
number = 124;

compare = zeros(1,10);

DataLabel = [clu_Left ClusterData_Left;clu_Straight ClusterData_Straight;...
    clu_Right ClusterData_Right];
[m n] = size(ClusterData_Left);
DataLabel_Random = DataLabel(randperm(size(DataLabel,1)),:);
Label = DataLabel_Random(:,1);
Data = DataLabel_Random(:,2:n+1);

SVM = [];
AccuracySVM = zeros(1,k);
    
for i = 1:1:TexNnumber
    for g = 0.01:0.1:1
        option = ['-c 2 -g ' g ' -b 1'];
        model = libsvmtrain(Label ,Data , option);
        [predict_label, accuracy, scores]  = libsvmpredict(Label, Data, model, '-b 1'); 

        ProN = 5;
        [a, b ] = sort(scores');
        [Row, Column] = size(scores);
        max_pro = [a(Column,:)', a(Column-1,:)', a(Column-2,:)', a(Column-3,:)', a(Column-4,:)'];
        max_index = [b(Column,:)', b(Column-1,:)', b(Column-2,:)', b(Column-3,:)', b(Column-4,:)'];
        patern = model.Label(max_index);
        [result_patern patern_pro] = SVMPatern(max_pro,patern,ProN);
        AccuracySVM(1,i) = Accuracy_New(Label,result_patern)*100/number; 
    end  
end

AccuracySVM_mean  = mean(AccuracySVM);
SVM = [SVM;AccuracySVM_mean];
NewSVM = mean(SVM)
compare(1,1) = NewSVM;

%%

SVM = [];
AccuracySVM = zeros(1,10);
    
for i = 1:1:TexNnumber
    
    option = ['-c 2 -g ' g ' -b 1'];
    model = libsvmtrain(Label ,Data , option);
    [predict_label, accuracy, scores]  = libsvmpredict(Label, Data, model, '-b 1'); 
    
    ProN = 5;
    [a, b ] = sort(scores');
    [Row, Column] = size(scores);
    max_pro = [a(Column,:)', a(Column-1,:)', a(Column-2,:)', a(Column-3,:)', a(Column-4,:)'];
    max_index = [b(Column,:)', b(Column-1,:)', b(Column-2,:)', b(Column-3,:)', b(Column-4,:)'];
    patern = model.Label(max_index);
    [result_patern patern_pro] = SVMPatern(max_pro,patern,ProN);
    AccuracySVM(1,i) = Accuracy_New(Label,result_patern)*100/number; 
    
end

AccuracySVM_mean  = mean(AccuracySVM);
SVM = [SVM;AccuracySVM_mean];
NewSVM = mean(SVM)
compare(1,2) = NewSVM;

%%

Label = LabelRecovery(Label);
g = 0.01;
SVM = [];
AccuracySVM = zeros(1,k);
for i = 1:1:TexNnumber
    
    
    option = ['-c 2 -g ' g ' -b 1'];
    model = libsvmtrain(Label ,Data , option);
    [predict_label1, accuracy1, scores1]  = libsvmpredict(Label, Data , model, '-b 1'); 
    AccuracySVM(1,i) = accuracy1(1,1);
    
end

AccuracySVM_mean  = mean(AccuracySVM);
SVM = [SVM;AccuracySVM_mean];
TraditionalSVM = mean(SVM)
compare(1,3) = TraditionalSVM ;


%%

SVM = [];
AccuracySVM = zeros(1,k);
for i = 1:1:TexNnumber
    
    
    option = ['-c 2 -g ' g ' -b 1'];
    model = libsvmtrain(Label ,Data , option);
    [predict_label1, accuracy1, scores1]  = libsvmpredict(Label, Data , model, '-b 1'); 
    AccuracySVM(1,i) = accuracy1(1,1);
    
end

AccuracySVM_mean  = mean(AccuracySVM);
SVM = [SVM;AccuracySVM_mean];
TraditionalSVM = mean(SVM)
compare(1,4) = TraditionalSVM ;
