%将筛选出来的数据存放到新的矩阵

function [Data_Selected] =  DataSelect(Data,selectedIndices)

    [Row Column] = size(Data);
    [n ~] = size(selectedIndices);
    %形成特征筛选后新的数据集(仅仅有数据，无label)
    Data_Selected = zeros(Row,n);

    for i= 1:n
       %特征放在后面
        Data_Selected(:,i) = [Data(:,selectedIndices(i))];
    end


end