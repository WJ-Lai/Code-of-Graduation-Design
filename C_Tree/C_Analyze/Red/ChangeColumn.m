clc;clear;
load('Cluster_Left.mat');
load('Cluster_Right.mat');
load('Cluster_Straight.mat');

final = [8,10,5,7,9,4,2,6,1,3];

%����ߵ�����������
Left(:,:) = ClusterData_Left(:,final);
Right(:,:) = ClusterData_Right(:,final);
Straight(:,:) = ClusterData_Straight(:,final);

%%
%��ת��-11��-12
%ģʽ�ֿ�
clu1 = [];
clu2 = [];

for i = 1:1:length(Left)
    if clu_Left(i,1) == -11
        clu1 = [clu1;Left(i,:)];
    end
    if clu_Left(i,1) == -12
        clu2 = [clu2;Left(i,:)];
    end
end

%ȡÿ��������ƽ��ֵ
clu1_mean = mean(clu1);
clu2_mean = mean(clu2); 
data = [clu1_mean;clu2_mean];
s = xlswrite('clu1.xls', data);

%%
%ֱ�У�1,2
%ģʽ�ֿ�
clu1 = [];
clu2 = [];

for i = 1:1:length(Straight)
    if clu_Straight(i,1) == 1
        clu1 = [clu1;Straight(i,:)];
    end
    if clu_Straight(i,1) == 2
        clu2 = [clu2;Straight(i,:)];
    end
end

%ȡÿ��������ƽ��ֵ
clu1_mean = mean(clu1);
clu2_mean = mean(clu2); 
data = [clu1_mean;clu2_mean];
s = xlswrite('clu2.xls', data);

%%
%��ת��11,12
%ģʽ�ֿ�
clu1 = [];
clu2 = [];

for i = 1:1:length(Right)
    if clu_Right(i,1) == 11
        clu1 = [clu1;Right(i,:)];
    end
    if clu_Right(i,1) == 12
        clu2 = [clu2;Right(i,:)];
    end
end

%ȡÿ��������ƽ��ֵ
clu1_mean = mean(clu1);
clu2_mean = mean(clu2); 
data = [clu1_mean;clu2_mean];
s = xlswrite('clu3.xls', data);