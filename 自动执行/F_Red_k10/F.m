%�о�SVM���ƹ����
function f = F()
clc;clear;
load('Cluster_Straight.mat');
load('Cluster_Right.mat');
load('Cluster_Left.mat');
TexNnumber = 10;
K = 10;

c_ini = 0.5;
c_finlVal = 10;
c_step = 0.5;
c_stepnubmer = round((c_finlVal-c_ini)/c_step + 1);
c = c_ini:c_step:c_finlVal;

g_ini = 0.5;
g_finlVal = 10;
g_step = 0.5;
g_stepnubmer = round((g_finlVal-g_ini)/g_step + 1);
g = g_ini:g_step:g_finlVal;

TreeNumber = 30;

New = zeros(TexNnumber,c_stepnubmer);
Tradition = zeros(TexNnumber,c_stepnubmer);

NewAcc = zeros(c_stepnubmer,g_stepnubmer);
OldAcc = zeros(c_stepnubmer,g_stepnubmer);

for t = 1:1:TexNnumber
    compare = zeros(2,c_stepnubmer);

    DataLabel = [clu_Left ClusterData_Left;clu_Straight ClusterData_Straight;...
        clu_Right ClusterData_Right];
    [m n] = size(ClusterData_Left);
    DataLabel_Random = DataLabel(randperm(size(DataLabel,1)),:);
    Label = DataLabel_Random(:,1);
    Data = DataLabel_Random(:,2:n+1);


    for i = 1:1:c_stepnubmer 
        for j = 1:1:g_stepnubmer 
            [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = NewKfold(K, Label, Data, c(1,i),g(1,j),TreeNumber);
            NewAcc(i,j) = NewAcc(i,j) + AccuracySVM_mean;
            compare(1,i) = AccuracySVM_mean;
        end
    end  

    %��ͳ����
    Label = LabelRecovery(Label)
    for i = 1:1:c_stepnubmer 
        for j = 1:1:g_stepnubmer 
            [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean] = Kfold(K, Label, Data, c(1,i),g(1,j),TreeNumber);
            OldAcc(i,j) = OldAcc(i,j) + AccuracySVM_mean;
            compare(2,i) = AccuracySVM_mean;
        end
    end
   
    New(t,:) = compare(1,:);
    Tradition(t,:) = compare(2,:);
    
end


%%
%��ͼ

NewAcc = NewAcc/TexNnumber;
OldAcc = OldAcc/TexNnumber;
Compare = NewAcc - OldAcc;

figure()
[C1,h1] = contour(c,g,NewAcc);
clabel(C1,h1);
xlabel('�ͷ�ϵ��c','fontsize',15)
ylabel('gammaϵ��','fontsize',15)
title('�·�������Ѱ��','fontsize',18);

figure()
[C2,h2] = contour(c,g,OldAcc);
clabel(C2,h2);
xlabel('�ͷ�ϵ��c','fontsize',15)
ylabel('gammaϵ��','fontsize',15)
title('��ͳ��������Ѱ��','fontsize',18);

figure()
[C3,h3] = contour(c,g,Compare);
clabel(C3,h3);
xlabel('�ͷ�ϵ��c','fontsize',15)
ylabel('gammaϵ��','fontsize',15)
title('�¾ɷ�����ֵ','fontsize',18);

figure();
NewMean = mean(New);
TraditionMean = mean(Tradition);
x = c_ini:c_step:c_finlVal;
plot(x,NewMean,'o-',x,TraditionMean,'*-');
set(gca,'XTick',[c_ini:c_step:c_finlVal])
set(gca,'YTick',[0:5:100])
legend('��SVM','��ͳSVM');
xlabel('�ͷ�ϵ��c','fontsize',15)
ylabel('׼ȷ�ʣ�%��','fontsize',15)
title('�ͷ�ϵ��c��׼ȷ�ʵ�Ӱ��','fontsize',18);
save data
end