%���࣬��ȷ����ѷ����������ת��
% Distance_Method = {'euclidean','squaredeuclidean','seuclidean','cityblock',...
%     'minkowski','chebychev','mahalanobis','cosine','correlation','spearman',...
%     'hamming','jaccard'};
%ѡ��ͬ����
% Linkage_Method = {'average','centroid','complete','median','single','ward','weighted'};

clear;clc;

load Data_Selected_Left.mat;
X = Data_Selected_Left;

Y = pdist(X,'squaredeuclidean');%����
Z = linkage(Y,'weighted');%ѡ����
cophenet(Z,Y)
figure();
H = dendrogram(Z,28);
set(H,'Color','k');
title('��������ͼ����ת��','Fontsize',18);
xlabel('�������','Fontsize',14)
ylabel('��׼�����루average��','Fontsize',14)

%��inconsistent�ó���ѷ������
%������ȣ�50
W = inconsistent(Z,50);
%�����������ľ������
% d_inconsistent = zeros(max(size(W))-1,1);
for i = 1:(max(size(W))-1)
    d_inconsistent(i,1) = W(i+1,4) - W(i,4);
end
d_inconsistent;

%%
%��ѷ������Ϊ��2
n = 3;
clu = cluster(Z,n);
cluA = 0;
cluB = 0;
cluC = 0;
for i = 1:length(clu)
    if clu(i) == 1
        clu_n(i,1) = {'Cluster1'};
        cluA = cluA+1;
    elseif clu(i) == 2
        clu_n(i,1) = {'Cluster2'};
        cluB = cluB+1;
    elseif clu(i) == 3
        clu_n(i,1) = {'Cluster3'};
        cluC = cluC+1;
%   elseif clu(i) == 4
%       clu_n(i,1) = {'Cluster4'};
    end
end

cluA
cluB
cluC
%%
%��������
figure();
andrewsplot(X,'group',clu_n,'quantile',.25,'LineWidth',2)
title('�������ߣ���ת��','fontsize',16);
ylabel('f(t)');

%%
%����ͼ


%%
%��ȡ���þ��࣬labelΪ-11��-12
for i = 1:length(clu)
    if clu(i) == 1
        clu(i,1) = -11;
    elseif clu(i) == 2
        clu(i,1) = -12;
    elseif clu(i) == 3
        clu(i,1) = -13;
    end
end

clu_Left = clu;
ClusterData_Left = Data_Selected_Left;
clearvars  -except ClusterData_Left clu_Left
save Cluster_Left