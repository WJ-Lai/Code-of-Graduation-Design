%���࣬��ȷ����ѷ����������ת��
% Distance_Method = {'euclidean','squaredeuclidean','seuclidean','cityblock',...
%     'minkowski','chebychev','mahalanobis','cosine','correlation','spearman',...
%     'hamming','jaccard'};
%ѡ��ͬ����
% Linkage_Method = {'average','centroid','complete','median','single','ward','weighted'};

clear;clc;

load Data_Selected_Right.mat;
X = Data_Selected_Right;

Y = pdist(X,'euclidean');%����
Z = linkage(Y,'weighted');%ѡ����
cophenet(Z,Y)
figure();
H = dendrogram(Z,35);
set(H,'Color','k');
set(gca,'FontSize',15);
xlabel('�������','Fontsize',24)
ylabel('��׼������','Fontsize',24)

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
n = 2;
clu = cluster(Z,n);
cluA = 0;
cluB = 0;
% cluC = 0;
% cluD = 0;
for i = 1:length(clu)
    if clu(i) == 1
        clu_n(i,1) = {'Cluster1'};
        cluA = cluA+1;
    elseif clu(i) == 2
        clu_n(i,1) = {'Cluster2'};
        cluB = cluB+1;
%     elseif clu(i) == 3
%         clu_n(i,1) = {'Cluster3'};
%         cluC = cluC+1;
%     elseif clu(i) == 4
%         clu_n(i,1) = {'Cluster4'};
%         cluD = cluD+1;
    end
end

cluA
cluB
% cluC
% cluD

%%
%��������
figure();
andrewsplot(X,'group',clu_n,'quantile',.25,'LineWidth',2)
set(gca,'FontSize',17);
xlabel('t','Fontsize',18)
ylabel('f(t)','Fontsize',18)

%%
%����ͼ


%%
%��ȡ���þ��࣬labelΪ11,12��13,14
for i = 1:length(clu)
    if clu(i) == 1
        clu(i,1) = 11;
    elseif clu(i) == 2
        clu(i,1) = 12;
%     elseif clu(i) == 3
%         clu(i,1) = 13;
%     elseif clu(i) == 4
%         clu(i,1) = 14;
    end
end

clu_Right = clu;
ClusterData_Right = Data_Selected_Right;
clearvars  -except ClusterData_Right clu_Right
save Cluster_Right