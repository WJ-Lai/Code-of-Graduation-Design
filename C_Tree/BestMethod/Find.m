%找到最佳聚类参数

clear;clc;

%条件设置
Distances = zeros(84,1);
Linkage = zeros(84,1);
%每个簇样本数量不低于12.5%
SampleNumber = 0.125;
%簇个数不大于3
ClusterNumber = 3;

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
for i = 1:1:12
    %i为7种Linkage_Method
%     figure();
    for j = 1:1:7
%         subplot(3,3,j)
        Y = pdist(X,Distance_Method{i});
        %选择不同linkage方式
        Z = linkage(Y,Linkage_Method{j});
        %行对应Distance_Method，列对应Linkage_Method
        Best_way(i,j) = cophenet(Z,Y);
%         H = dendrogram(Z,100);
%         set(H,'Color','k');
%         title('聚类树形图（右转）','Fontsize',18);
%         xlabel('样本编号','Fontsize',14)
%         ylabel('标准化距离（average）','Fontsize',14)
    end
end
max(Best_way)
max(ans)

%矩阵中cophenet由大到小排列,并存放对应位置
for k = 1:1:84
    
    %若没有系数相同的参数
    if length(find(Best_way == max(max(Best_way)))) == 1
        [Distances(k,1) Linkage(k,1)] = find(Best_way == max(max(Best_way)));
        Best_way(Distances(k,1),Linkage(k,1)) = 0;
    else 
        [DistancesRepeat LinkageRepeat] = find(Best_way == max(max(Best_way)));
        Distances(k,1) = DistancesRepeat(1,1);
        Linkage(k,1) = LinkageRepeat(1,1);
        Best_way(Distances(k,1),Linkage(k,1)) = 0;
    end
    
end

%按照cophenet到小，注意检验簇数量和簇个数是否满足
Y = pdist(X,Distance_Method{11});
Z = linkage(Y,Linkage_Method{3});
H = dendrogram(Z,100);