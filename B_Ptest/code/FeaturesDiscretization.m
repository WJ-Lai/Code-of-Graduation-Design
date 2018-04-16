%% 函数用于离散化数据为FEAST算法筛选指标作准备
% 输入：训练集数据
% 输出：离散化后的训练集数据

function [ Data_discrete ] = FeaturesDiscretization( Data )
    
    [Row,Column]=size(Data);
    %等分成10份
    n = 10;
    %最大值
    A_max = max(Data);
    %最小值
    A_min = min(Data);
    %每一份之间间隔
    A = [(A_max-A_min)/n];
    %L存放各个特征的10个区间的边界值，因此有11个边界值
    L = zeros(10,Column);
    for i = 1:n+1
        L(i,:) = A_min+A*(i-1);
    end
    %训练集矩阵每一列作为一个单独的区间，上下限是这一列的最大值和最小值
    %然后等分10份，再看这一列的每一个数据落在哪一个区间

    boundary = zeros(10,Column);
    for i = 1:n
        boundary(i,:) = A_min+A*(i);
    end
    Data_discrete = zeros(Row,Column);
    for j = 1:Column
        for i = 1:min(size(Data))
            for k = 1:10
                %第一个区间为闭区间[],其余区间为左开右闭合（]
                if boundary(k,j)>=Data(i,j)
                    Data_discrete(i,j) = k;    %存放离散数据
                    break;
                end  
            end
        end
    end


end