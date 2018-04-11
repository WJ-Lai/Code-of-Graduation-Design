%计算RF准确率

function RF_accuracy = RF_Accuracy(test_label,RF_Predict)
    RF_accuracy = 0;
    for i = 1:length(test_label)
        if test_label(i,1) == str2double(RF_Predict{i,1})
            RF_accuracy = RF_accuracy + 1;
        end
    end

end
