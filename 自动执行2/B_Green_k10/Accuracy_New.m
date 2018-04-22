%计算新方法准确率

function  accuracy = Accuracy_New(test_label,result_patern)
    accuracy = 0;
    for i = 1:length(test_label)
        if test_label(i,1) <0
            test_label(i,1) = -1;
        elseif test_label(i,1) >10
            test_label(i,1) = 1;
        else
            test_label(i,1) = 0;
        end
    end
    
   for j = 1:length(test_label)
       if test_label(j,1) == result_patern(j,1)
            accuracy = accuracy + 1;
       end
   end
   fprintf('Accuracy = %.4f%% (%d/%d) (Newclassification)\n',100*accuracy/length(test_label),accuracy,length(test_label))
end