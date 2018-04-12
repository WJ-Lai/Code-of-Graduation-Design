%
function [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean ] = LeaveOne(Label, Data, c,g,TreeNumber)

    [m n] = size(Data);
    
    %每个单独为1组，m组
    SplitData = cell(2,m);
    for i = 1:1:m
        SplitData{1,i} = Data(i,:);
        SplitData{2,i} = Label(i,:);
    end
    
    %轮流充当train和text组
    AccuracySVM = zeros(1,m);%存放每次的准确率
    AccuracyRF = zeros(1,m);
    

    
    for i = 1:1:m
        test_label = SplitData{2,i};
        test_data = SplitData{1,i};
        
        train_label = [];
        train_data = [];
        
        for j = 1:1:m
            if j ~= i
                train_label = [train_label;SplitData{2,j}];
                train_data = [train_data;SplitData{1,j}];
            end
        end
    
    %新label下预测
    option = ['-c ',num2str(c),' -g ',num2str(g),' -b 1'];
    model = libsvmtrain(train_label ,train_data ,option);
    [predict_label, accuracy, scores]  = libsvmpredict(test_label, test_data , model, '-b 1'); 
    
    %转换为原始label
    [max_pro, max_index ] = sort(scores','descend');
    [Row, Column] = size(scores);
    patern = model.Label(max_index);
    [result_patern patern_pro] = SVMPatern(max_pro,patern);
    AccuracySVM(1,i) = Accuracy_New(test_label,result_patern);
    
    
    
    
%     计算新方法准确率(RF)
%     RFmodel = TreeBagger(TreeNumber, train_data, train_label);
%     [~,RFScores] = predict(RFmodel, test_data);
% 
%     排序
%     [a, b ] = sort(RFScores');
%     [Row, Column] = size(RFScores);
%     max_pro = [a(Column,:)', a(Column-1,:)', a(Column-2,:)', a(Column-3,:)', a(Column-4,:)'];
%     max_index = [b(Column,:)', b(Column-1,:)', b(Column-2,:)', b(Column-3,:)', b(Column-4,:)'];
% 
%     最大概率三种模式
%     patern = RFmodel.ClassNames(max_index);
%     result_patern为对应预测意图：-1,0,1
%     [result_patern patern_pro] = RFPatern(max_pro,patern,5);
%     AccuracyRF(1,i) = Accuracy_New(test_label,result_patern)*100/number;

    end
    
    
    AccuracySVM_mean  = mean(AccuracySVM);
%     AccuracySVM_mean = 1
%     AccuracyRF_mean  = mean(AccuracyRF);
    AccuracyRF_mean  = 1;




end