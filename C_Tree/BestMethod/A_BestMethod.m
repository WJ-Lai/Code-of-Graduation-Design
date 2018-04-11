%层次聚类
%确定最佳方法

clear;clc;

%%
%更改此处得到不同意图

% load Data_Selected_Left.mat;
% X = Data_Selected_Left;

% load Data_Selected_Straight.mat;
% X = Data_Selected_Straight;

load Data_Selected_Right.mat;
X = Data_Selected_Right;

%%
%选择不同距离
Distance_Method = {'euclidean','squaredeuclidean','seuclidean','cityblock',...
    'minkowski','chebychev','mahalanobis','cosine','correlation','spearman',...
    'hamming','jaccard'};
Linkage_Method = {'average','centroid','complete','median','single','ward','weighted'};
%存放不同方式下cophenet的值
Best_way = zeros(12,7);
% format long
% i为12种Distance_Method
for i = 1:12
    %i为7种Linkage_Method
    for j = 1:7
        Y = pdist(X,Distance_Method{i});
        %选择不同linkage方式
        Z = linkage(Y,Linkage_Method{j});
        %行对应Distance_Method，列对应Linkage_Method
        Best_way(i,j) = cophenet(Z,Y);
    end
end
max(Best_way)
max(ans)