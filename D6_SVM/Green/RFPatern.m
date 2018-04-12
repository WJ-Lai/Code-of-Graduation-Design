%输入概率前三的模式，返回最优意图 (RF)
%左转：-11，-12
%直行：1,2
%右转：11,12和13
function [result_patern patern_pro]  = RFPatern(max_pro, patern, n)

    %存各种模式的下，左转直行右转的总概率
    patern_pro = zeros(length(max_pro),n);
    
    for i = 1:length(max_pro)
        for j = 1:n
            if str2double(patern{i,j}) < 0
                patern_pro(i,1) = patern_pro(i,1) + max_pro(i,j);
            elseif str2double(patern{i,j}) > 0 && str2double(patern{i,j}) < 10
                patern_pro(i,2) = patern_pro(i,2) + max_pro(i,j);
            elseif str2double(patern{i,j}) > 10
                patern_pro(i,3) = patern_pro(i,3)+ max_pro(i,j);
            end
        end
        [a b] = max(patern_pro');
        b = b-2;
        %返回属于哪种意图:-1,0,1
        result_patern = b';
        
    end
end