%研究SVM改善过拟合
clc;clear;
load('Cluster_Straight.mat');
load('Cluster_Right.mat');
load('Cluster_Left.mat');
TexNnumber = 5;
k = 1;
number = 124;
finlVal = 4;
goin = 0.08;
bujin = finlVal/goin;

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
    for g = 0.01:goin:finlVal

        option = ['-c 2 -g ' num2str(g) ' -b 1'];
        model = libsvmtrain(Label ,Data , option);
        [predict_label, accuracy, scores]  = libsvmpredict(Label, Data, model, '-b 1'); 

        ProN = 5;
        [a, b ] = sort(scores');
        [Row, Column] = size(scores);
        max_pro = [a(Column,:)', a(Column-1,:)', a(Column-2,:)', a(Column-3,:)', a(Column-4,:)'];
        max_index = [b(Column,:)', b(Column-1,:)', b(Column-2,:)', b(Column-3,:)', b(Column-4,:)'];
        patern = model.Label(max_index);
        [result_patern patern_pro] = SVMPatern(max_pro,patern,ProN);
        compare(1,i) = Accuracy_New(Label,result_patern)*100/number;
        i = i+1;

    end  

    %传统方法
    Label = LabelRecovery(Label)
    i = 1;
    for g = 0.01:goin:finlVal

        option = ['-c 2 -g ' num2str(g) ' -b 1'];
        model = libsvmtrain(Label ,Data , option);
        [predict_label1, accuracy1, scores1]  = libsvmpredict(Label, Data , model, '-b 1'); 
        compare(2,i) = accuracy1(1,1);
        i = i+1;
    end
   
    New(t,:) = compare(1,:);
    Tradition(t,:) = compare(2,:);
    
end

figure();
NewMean = mean(New);
TraditionMean = mean(Tradition);
x = 0.01:goin:finlVal;
plot(x,NewMean,'o-',x,TraditionMean,'*-');
set(gca,'XTick',[0.01:goin:finlVal])
set(gca,'YTick',[0:10:100])
