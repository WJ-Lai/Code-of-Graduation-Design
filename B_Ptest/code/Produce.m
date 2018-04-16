%生成训练集、测试集
%输入筛选后的数据集,Label和测试集个数
%输出训练集和测试集

function [train_label, train_data,test_label, test_data] = Produce(Data_Select,Label, TestNumber)

    [row column] = size(Data_Select);
    %取训练集
    n = row-TestNumber;
    train_label = Label(1:n,:);
    train_data = Data_Select(1:n,:);

    %取测试集
    test_label = Label(n+1:row,:);
    test_data = Data_Select(n+1:row,:);

end