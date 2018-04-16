%特征选择函数
%包含数据离散化和FEAST算法
%输入：数据集
%输出：离散后数据集，FEAST选出的特征编号

function [selectedIndices,Data_discrete] = FeatureSelect( Data,label,n,a)

    if a == 1
        [ Data_discrete ] = FeaturesDiscretization( Data );
    elseif a ==2
        %方法二是高级离散
        [ Data_discrete ] = FeaturesDiscretization2( Data );
    end
    %FEAST筛选出10个特征
    selectedIndices = feast('jmi',n,Data_discrete,label);


end