%���������ȼ���ָ��Ԫ�ػ���
%���룺�����ȼ�����Ҫ����λ��,��Second�еĵ�y��Ԫ���滻First�еĵ�x��Ԫ��
%�µĵȼ�����

function [NewFirst NewSecond] = replace(First, x,Second, y)

    %��ʼ���¾���
    NewFirst = First;
    NewSecond = Second;

    %��ʼ�滻
    NewFirst(x,:) = Second(y,:);
    NewSecond(y,:) = First(x,:);
    
end