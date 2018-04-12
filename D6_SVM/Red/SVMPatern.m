%输入概率前三的模式，返回最优意图 (RF)
%左转：-11，-12
%直行：1,2
%右转：11,12和13
function [result_patern patern_pro]  = SVMPatern(max_pro, patern)

    %存各种模式的下，左转直行右转的总概率
    [m n] = size(max_pro);
    patern_pro = zeros(length(max_pro),3);
    if m == 1
       patern = patern';  
    end
    for i = 1:1:m
        for j = 1:1:n
            if patern(i,j) < 0
                patern_pro(i,1) = patern_pro(i,1) + max_pro(i,j);
            elseif patern(i,j) > 0 && patern(i,j) < 10
                patern_pro(i,2) = patern_pro(i,2) + max_pro(i,j);
            elseif patern(i,j) > 10
                patern_pro(i,3) = patern_pro(i,3)+ max_pro(i,j);
            end
        end
    end
    [a b] = max(patern_pro');
    b = b-2;
    %返回属于哪种意图:-1,0,1
    result_patern = b';
end