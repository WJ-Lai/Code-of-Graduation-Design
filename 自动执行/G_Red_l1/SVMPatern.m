%�������ǰ����ģʽ������������ͼ (RF)
%��ת��-11��-12
%ֱ�У�1,2
%��ת��11,12��13
function [result_patern patern_pro]  = SVMPatern(max_pro, patern)

    %�����ģʽ���£���תֱ����ת���ܸ���
    patern_pro = zeros(1,3);
    
    for i = 1:1:length(max_pro)
        if patern(i,1) < 0
            patern_pro(1,1) = patern_pro(1,1) + max_pro(i,1);
        elseif patern(i,1) > 0 && patern(i,1) < 10
            patern_pro(1,2) = patern_pro(1,2) + max_pro(i,1);
        elseif patern(i,1) > 10
            patern_pro(1,3) = patern_pro(1,3)+ max_pro(i,1);
        end
    end
    [a b] = max(patern_pro');
    %��������������ͼ:-1,0,1
    b = b - 2;
    result_patern = b';
end