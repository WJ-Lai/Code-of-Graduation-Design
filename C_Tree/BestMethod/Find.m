%找到最佳聚类参数

clear;clc;

%条件设置
Distances = zeros(84,1);
Linkage = zeros(84,1);
%每个簇样本数量不低于12.5%
SampleNumber = 0.3;
%簇个数不大于3
ClusterNumber = 3;

load Data_Selected_Left.mat;
X = Data_Selected_Left;

% load Data_Selected_Straight.mat;
% X = Data_Selected_Straight;

% load Data_Selected_Right.mat;
% X = Data_Selected_Right;



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
Min = ceil(SampleNumber*length(X));
for k = 1:1:84
    
    Y = pdist(X,Distance_Method{Distances(k,1)});
    Z = linkage(Y,Linkage_Method{Linkage(k,1)});
    H = dendrogram(Z,100);
    set(H,'Color','k');
    title('聚类树形图（右转）','Fontsize',18);
    xlabel('样本编号','Fontsize',14)
    ylabel('标准化距离（average）','Fontsize',14)
    
    %由inconsistent得出最佳分类个数
    %计算深度：100
    W = inconsistent(Z,50);
    %计算增幅最多的聚类序号
    % d_inconsistent = zeros(max(size(W))-1,1);
    for i = 1:(max(size(W))-1)
        d_inconsistent(i,1) = W(i+1,4) - W(i,4);
    end
    
    %自动判断最佳聚类个数,两类或三类
    %若倒数第一大于倒数第二，则两类
    if d_inconsistent(max(size(W))-1,1) > d_inconsistent(max(size(W))-2,1)
        n = 2;
        clu = cluster(Z,n);
        cluA = 0;
        cluB = 0;
        for i = 1:length(clu)
            if clu(i) == 1
                clu_n(i,1) = {'Cluster1'};
                cluA = cluA+1;
            elseif clu(i) == 2
                clu_n(i,1) = {'Cluster2'};
                cluB = cluB+1;
            end
        end  
        %若三类样本数均大于SampleNumber，则break
        if cluA >= Min & cluB >= Min
            cluA
            cluB
            break;
        end

        
    else
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
            end
        end
        
        %若三类样本数均大于SampleNumber，则break
        if cluA >= Min & cluB >= Min & cluC >= Min
            cluA 
            cluB 
            cluC
            break;
        end
        
    end
  
end

%找到最佳参数及其对应的cophenet
k
Distance_Method{Distances(k,1)}
Linkage_Method{Linkage(k,1)}
cophenet(Z,Y)