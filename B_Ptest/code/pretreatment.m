%pretreatment

function [train_data, test_data] = pretreatment(train_data, test_data)

    [train_data,pstrain] = mapminmax(train_data');
    pstrain.ymin = 0;
    pstrain.ymax = 1;
    [train_data,pstrain] = mapminmax(train_data,pstrain);

    [test_data,pstest] = mapminmax(test_data');
    pstest.ymin = 0;
    pstest.ymax = 1;
    [test_data,pstest] = mapminmax(test_data,pstest);

    train_data = train_data';
    test_data = test_data';

end