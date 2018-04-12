%
function [AccuracySVM AccuracySVM_mean AccuracyRF AccuracyRF_mean ] = LeaveOne_old(Label, Data, c,g,TreeNumber)

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
    
    option = ['-c ',num2str(c),' -g ',num2str(g),' -b 1'];
    model = libsvmtrain(train_label ,train_data , option);
    [predict_label, accuracy, scores]  = libsvmpredict(test_label, test_data , model, '-b 1'); 
    AccuracySVM(1,i) = accuracy(1,1);
    
%     Factor = TreeBagger(TreeNumber, train_data, train_label);
%     [RF_Predict,RFScores] = predict(Factor, test_data); 
%     AccuracyRF(1,i) = RF_Accuracy(test_label,RF_Predict)*100/number;
    end
    
    
    AccuracySVM_mean  = mean(AccuracySVM);
%     AccuracyRF_mean  = mean(AccuracyRF);
%     AccuracySVM_mean = 1;
    AccuracyRF_mean  = 1;

end