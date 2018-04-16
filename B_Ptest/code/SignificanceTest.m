%œ‘÷¯–‘ºÏ—Èsignificance test

function p = SignificanceTest(data,label)

    [m n] = size(data);
    p = zeros(n,1);
    for i = 1:1:n

        X = data(:,i);
        p(i,1) = anova1(X,label,'off');

    end

end