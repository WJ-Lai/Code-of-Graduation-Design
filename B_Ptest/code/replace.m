%用于两个等级内指定元素互换
%输入：两个等级矩阵，要换的位置,用Second中的第y个元素替换First中的第x个元素
%新的等级矩阵

function [NewFirst NewSecond] = replace(First, x,Second, y)

    %初始化新矩阵
    NewFirst = First;
    NewSecond = Second;

    %开始替换
    NewFirst(x,:) = Second(y,:);
    NewSecond(y,:) = First(x,:);
    
end