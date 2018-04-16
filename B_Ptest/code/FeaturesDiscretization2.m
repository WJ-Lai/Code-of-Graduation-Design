function [ DiscreteData ] = FeaturesDiscretization( Data )
%% 函数用于离散化数据为FEAST算法筛选指标作准备
% 输入：训练集数据
% 输出：离散化后的训练集数据以及阈值
%% 
DiscreteNums = 20; 
PercGap = 100/DiscreteNums;
for i = 1:1:length(Data(1,:))  
    for j =1:1:DiscreteNums
        Threshold(i,j) = prctile(Data(:,i),j*PercGap);  %判断相关性
    end
end

%离散化
for i = 1:1:length(Data(:,1))  
    for j = 1:1:length(Data(1,:))  
        for k = 1:1:DiscreteNums  
            if k == 1
                if Data(i,j) <= Threshold(j,k)
                    DiscreteData(i,j) = k;
                end
            else
                if Data(i,j) > Threshold(j,k-1) && Data(i,j) <= Threshold(j,k)
                    DiscreteData(i,j) = k;
                end
            end
        end
    end
end
end

