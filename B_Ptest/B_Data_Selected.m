%提取特征数据

%%
%总数据
clear;clc;
load('Red_EyeDatabase.mat');
[Row Column] = size(Data);
n=10;

selectedIndices = [34;6;13;1;2;8;30;25;18;28];
%形成特征筛选后新的数据集(仅仅有数据，无label)
Data_Selected = zeros(Row,n);

for i= 1:n
   %特征放在后面
    Data_Selected(:,i) = [Data(:,selectedIndices(i))];
end

[Data_Selected, ~] = pretreatment(Data_Selected, Data_Selected);

clearvars -except Data_Selected Label
save Data_Selected;

%%
%左转数据L
clear;clc;
load('Red_EyeDatabase_Left.mat');
load('Red_EyeDatabase.mat');
[Row Column] = size(Data_Left);
n=10;

selectedIndices = [15;1;2;38;4;28;34;25;30;12];
%形成特征筛选后新的数据集(仅仅有数据，无label)
Data_Selected_Left = zeros(Row,n);

for i= 1:n
   %特征放在后面
    Data_Selected_Left(:,i) = [Data_Left(:,selectedIndices(i))];
end

[Data_Selected_Left, ~] = pretreatment(Data_Selected_Left, Data_Selected_Left);

clearvars -except Data_Selected_Left Label_Left
save Data_Selected_Left;

%%
%直行数据S
clear;clc;
load('Red_EyeDatabase_Straight.mat');
load('Red_EyeDatabase.mat');
[Row Column] = size(Data_Straight);
n=10;

selectedIndices = [15;1;2;38;4;28;34;25;30;12];
%形成特征筛选后新的数据集(仅仅有数据，无label)
Data_Selected_Straight = zeros(Row,n);

for i= 1:n
   %特征放在后面
    Data_Selected_Straight(:,i) = [Data_Straight(:,selectedIndices(i))];
end

[Data_Selected_Straight, ~] = pretreatment(Data_Selected_Straight, Data_Selected_Straight);

clearvars -except Data_Selected_Straight Label_Straight
save Data_Selected_Straight;

%%
%右转数据R
clear;clc;
load('Red_EyeDatabase_Right.mat');
load('Red_EyeDatabase.mat');
[Row Column] = size(Data_Right);
n=10;

selectedIndices = [15;1;2;38;4;28;34;25;30;12];
%形成特征筛选后新的数据集(仅仅有数据，无label)
Data_Selected_Right = zeros(Row,n);

for i= 1:n
   %特征放在后面
    Data_Selected_Right(:,i) = [Data_Right(:,selectedIndices(i))];
end

[Data_Selected_Right, ~] = pretreatment(Data_Selected_Right, Data_Selected_Right);

clearvars -except Data_Selected_Right Label_Right
save Data_Selected_Right;