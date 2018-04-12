%label±ä»Ø-1,0,1

function test_label =  LabelRecovery(test_label)

    for i = 1:length(test_label)
        if test_label(i,1) < 0
            test_label(i,1) = -1;
        elseif test_label(i,1) > 10
            test_label(i,1) = 1;
        else
            test_label(i,1) = 0;
        end
    end
    
end

