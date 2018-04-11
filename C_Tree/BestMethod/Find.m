clear;clc;


% load Data_Selected_Left.mat;
% X = Data_Selected_Left;

% load Data_Selected_Straight.mat;
% X = Data_Selected_Straight;

load Data_Selected_Right.mat;
X = Data_Selected_Right;



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
    figure();
    for j = 1:3
        subplot(2,2,j)
        Y = pdist(X,Distance_Method{i});
        %选择不同linkage方式
        Z = linkage(Y,Linkage_Method{j+4});
        %行对应Distance_Method，列对应Linkage_Method
        Best_way(i,j) = cophenet(Z,Y);
        H = dendrogram(Z,100);
        set(H,'Color','k');
        title('聚类树形图（右转）','Fontsize',18);
        xlabel('样本编号','Fontsize',14)
        ylabel('标准化距离（average）','Fontsize',14)
    end
end
max(Best_way)
max(ans)
