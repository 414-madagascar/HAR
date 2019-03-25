load Boxing_p5&p6
sample_data = allUV;
load Boxing_p7&p8
test_data = allUV;

[row1,col1] = size(sample_data);
size_sample = row1;
[row2,col2] = size(test_data);
size_test = row2;

if size_sample > size_test
    max_data = sample_data;
    min_data = test_data;
    max_size = size_sample;
    min_size = size_test;
    size_difference = (max_size - min_size)/1001;
else
    max_data = test_data;
    min_data = sample_data;
    max_size = size_test;
    min_size = size_sample;
    size_difference = (max_size - min_size)/1001;
end    
%diff_data = [];
%diff_data_x_set = [];
%sumX2 = sum(min_data(:,1));
%sumY2 = sum(min_data(:,2));
diff_data_x = 0;
diff_data_y = 0;

for i = 1:(max_size - min_size)
    %fprintf(1,"Continuing...")
    fprintf(1,"Continuing...%d\r",i)
    %sumX1 = sum(max_data(i:min_size,1));
    %sumX1 = sumX1 + test_data(i,1);
    %sumY1 = sum(max_data(i:min_size,2));
    for j = 1:size_difference
        abs_x = abs(max_data(i+j*1001,1)-min_data(j,1));
        diff_data_x = diff_data_x + abs_x;
        abs_y = abs(max_data(i+j*1001,2)-min_data(j,2));
        diff_data_y = diff_data_y + abs_y;
    end
    sumX = [sumX;diff_data_x];
    sumY = [sumY;diff_data_y];
    %diff_data = [diff_data;diff_data_x diff_data_y];
    
end


disp(min(sumX))
disp(min(sumY))
