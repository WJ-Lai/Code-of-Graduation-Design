%�����������
function [Data_Random Label_Random] = RandomData(Data, Label)%random���ݣ���label��

    %��data��label�ϲ�������
    [row column] = size(Data);
    DataLabel = [Label Data];
    DataLabel_Random = DataLabel(randperm(size(DataLabel,1)),:);

    %��data��label����
    Label_Random = DataLabel_Random(:,1);
    Data_Random = DataLabel_Random(:,2:column+1);
    
end
