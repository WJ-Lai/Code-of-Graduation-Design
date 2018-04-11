%等高线demo

clc;clear;
z = rand(5,5);
X = 0:0.5:2;
Y = [2;4;6;8;10];
for i = 1:1:5
    for j = 1:1:5
%         z(i,j) = X(i,1)+Y(j,1);    
    end
end
contour(X,Y,z)

set(gca,'XTick',[0:0.5:g_finlVal])
set(gca,'YTick',[0:5:100])
legend('新SVM','传统SVM');
xlabel('gamma系数','fontsize',15)
ylabel('准确率（%）','fontsize',15)
title('gamma系数对准确率的影响','fontsize',18);