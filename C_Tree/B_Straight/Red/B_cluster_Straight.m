%���࣬��ȷ����ѷ��������ֱ�У�
% Distance_Method = {'euclidean','squaredeuclidean','seuclidean','cityblock',...
%     'minkowski','chebychev','mahalanobis','cosine','correlation','spearman',...
%     'hamming','jaccard'};
%ѡ��ͬ����
% Linkage_Method = {'average','centroid','complete','median','single','ward','weighted'};

clear;clc;

load Data_Selected_Straight.mat;
X = Data_Selected_Straight;

Y = pdist(X,'chebychev');%����
Z = linkage(Y, 'ward');%ѡ����
cophenet(Z,Y);
figure();
H = dendrogram(Z,40);
set(H,'Color','k');
set(gca,'FontSize',15);
xlabel('�������','Fontsize',24)
ylabel('��׼������','Fontsize',24)

%��inconsistent�ó���ѷ������
%������ȣ�100
W = inconsistent(Z,50);
%�����������ľ������
% d_inconsistent = zeros(max(size(W))-1,1);
for i = 1:(max(size(W))-1)
    d_inconsistent(i,1) = W(i+1,4) - W(i,4);
end
d_inconsistent;

%%
%��ѷ������Ϊ��2
%%
%��ѷ������Ϊ��4
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
%   elseif clu(i) == 4
%       clu_n(i,1) = {'Cluster4'};
%       cluD = cluD+1;
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
%��ȡ���þ��࣬labelΪ01��02
for i = 1:length(clu)
    if clu(i) == 1
        clu(i,1) = 01;
    elseif clu(i) == 2
        clu(i,1) = 02;
%     elseif clu(i) == 3
%         clu(i,1) = 03;
%     elseif clu(i) == 4
%         clu(i,1) = 04;
    end
end

clu_Straight = clu;
ClusterData_Straight = Data_Selected_Straight;
clearvars  -except ClusterData_Straight clu_Straight
save Cluster_Straight