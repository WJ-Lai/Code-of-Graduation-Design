%����ѵ���������Լ�
%����ɸѡ������ݼ�,Label�Ͳ��Լ�����
%���ѵ�����Ͳ��Լ�

function [train_label, train_data,test_label, test_data] = Produce(Data_Select,Label, TestNumber)

    [row column] = size(Data_Select);
    %ȡѵ����
    n = row-TestNumber;
    train_label = Label(1:n,:);
    train_data = Data_Select(1:n,:);

    %ȡ���Լ�
    test_label = Label(n+1:row,:);
    test_data = Data_Select(n+1:row,:);

end