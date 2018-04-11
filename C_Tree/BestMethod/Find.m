%�ҵ���Ѿ������

clear;clc;

%��������
Distances = zeros(84,1);
Linkage = zeros(84,1);
%ÿ������������������12.5%
SampleNumber = 0.3;
%�ظ���������3
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
%��Ų�ͬ��ʽ��cophenet��ֵ
Best_way = zeros(12,7);
% format long
% iΪ12��Distance_Method
for i = 1:1:12
    %iΪ7��Linkage_Method
%     figure();
    for j = 1:1:7
%         subplot(3,3,j)
        Y = pdist(X,Distance_Method{i});
        %ѡ��ͬlinkage��ʽ
        Z = linkage(Y,Linkage_Method{j});
        %�ж�ӦDistance_Method���ж�ӦLinkage_Method
        Best_way(i,j) = cophenet(Z,Y);
%         H = dendrogram(Z,100);
%         set(H,'Color','k');
%         title('��������ͼ����ת��','Fontsize',18);
%         xlabel('�������','Fontsize',14)
%         ylabel('��׼�����루average��','Fontsize',14)
    end
end
max(Best_way)
max(ans)

%������cophenet�ɴ�С����,����Ŷ�Ӧλ��
for k = 1:1:84
    
    %��û��ϵ����ͬ�Ĳ���
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

%����cophenet��С��ע�����������ʹظ����Ƿ�����
Min = ceil(SampleNumber*length(X));
for k = 1:1:84
    
    Y = pdist(X,Distance_Method{Distances(k,1)});
    Z = linkage(Y,Linkage_Method{Linkage(k,1)});
    H = dendrogram(Z,100);
    set(H,'Color','k');
    title('��������ͼ����ת��','Fontsize',18);
    xlabel('�������','Fontsize',14)
    ylabel('��׼�����루average��','Fontsize',14)
    
    %��inconsistent�ó���ѷ������
    %������ȣ�100
    W = inconsistent(Z,50);
    %�����������ľ������
    % d_inconsistent = zeros(max(size(W))-1,1);
    for i = 1:(max(size(W))-1)
        d_inconsistent(i,1) = W(i+1,4) - W(i,4);
    end
    
    %�Զ��ж���Ѿ������,���������
    %��������һ���ڵ����ڶ���������
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
        %������������������SampleNumber����break
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
        
        %������������������SampleNumber����break
        if cluA >= Min & cluB >= Min & cluC >= Min
            cluA 
            cluB 
            cluC
            break;
        end
        
    end
  
end

%�ҵ���Ѳ��������Ӧ��cophenet
k
Distance_Method{Distances(k,1)}
Linkage_Method{Linkage(k,1)}
cophenet(Z,Y)