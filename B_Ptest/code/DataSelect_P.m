%��ɸѡ���������ݴ�ŵ��µľ���

function [Data_Selected_P] =  DataSelect_P(p, selectedIndices)

    [Row ~] = size(p);
    [n ~] = size(selectedIndices);
    Data_Selected_P = zeros(n,1);
    
    for i= 1:1:n
        
         Data_Selected_P(i,1) = p(selectedIndices(i,1),1);
        
    end
   
end