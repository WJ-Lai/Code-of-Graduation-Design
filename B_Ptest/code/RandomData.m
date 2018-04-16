%生成随机矩阵
function [Data_Random Label_Random] = RandomData(Data, Label)%random数据（与label）

    %将data和label合并并打乱
    [row column] = size(Data);
    DataLabel = [Label Data];
    DataLabel_Random = DataLabel(randperm(size(DataLabel,1)),:);

    %将data和label分离
    Label_Random = DataLabel_Random(:,1);
    Data_Random = DataLabel_Random(:,2:column+1);
    
end
