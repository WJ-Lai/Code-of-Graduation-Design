%输入概率前三的模式，返回最优意图 (RF)
%左转：-11，-12
%直行：1,2
%右转：11,12和13
function [result_patern patern_pro]  = SVMPatern(max_pro, patern)

    %存各种模式的下，左转直行右转的总概率
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
    %返回属于哪种意图:-1,0,1
    b = b - 2;
    result_patern = b';
end