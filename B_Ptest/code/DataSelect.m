%��ɸѡ���������ݴ�ŵ��µľ���

function [Data_Selected] =  DataSelect(Data,selectedIndices)

    [Row Column] = size(Data);
    [n ~] = size(selectedIndices);
    %�γ�����ɸѡ���µ����ݼ�(���������ݣ���label)
    Data_Selected = zeros(Row,n);

    for i= 1:n
       %�������ں���
        Data_Selected(:,i) = [Data(:,selectedIndices(i))];
    end


end