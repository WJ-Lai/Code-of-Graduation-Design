%计算SVM与RF准确率

function [SVMaccuracy RFaccuracy] = test(train_label, train_data,test_label, test_data)
   
    %SVM
    SVMmodel = libsvmtrain(train_label, train_data, '-c 2 -g 0.01');
    [predict_label, accuracy1, dec_values] = libsvmpredict(test_label, test_data ,SVMmodel); 
    SVMaccuracy = accuracy1(1,1);
    
    %RF
    RFmodel=classRF_train( train_data,train_label);
    [RFpredict_label votes] = classRF_predict(test_data,RFmodel);
    accuracy2 = classRF_accuracy(test_label, RFpredict_label);
    RFaccuracy = 100*accuracy2/length(test_label);
    
end