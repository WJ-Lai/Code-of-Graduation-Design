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
%��Ų�ͬ��ʽ��cophenet��ֵ
Best_way = zeros(12,7);
% format long
% iΪ12��Distance_Method
for i = 1:12
    %iΪ7��Linkage_Method
    figure();
    for j = 1:3
        subplot(2,2,j)
        Y = pdist(X,Distance_Method{i});
        %ѡ��ͬlinkage��ʽ
        Z = linkage(Y,Linkage_Method{j+4});
        %�ж�ӦDistance_Method���ж�ӦLinkage_Method
        Best_way(i,j) = cophenet(Z,Y);
        H = dendrogram(Z,100);
        set(H,'Color','k');
        title('��������ͼ����ת��','Fontsize',18);
        xlabel('�������','Fontsize',14)
        ylabel('��׼�����루average��','Fontsize',14)
    end
end
max(Best_way)
max(ans)
