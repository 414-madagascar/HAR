%Histogram subtraction function
%input (feature video histogram, test video optical flow vector histogram)
%two histograms need has two rows, the first one represent the x direction
%the second one need to represent the y direction
%return a number represents histogram distance difference level


function [Result_list] = calculate_difference(sample_data_input,test_data_input)

%load data and use the threshold to avoid image offset
load(sample_data_input)
data = allUV;
thresh_hold_x = 70000;
thresh_hold_y = 120000;
sample_data_x = data(:,1);
sample_data_y = data(:,2);
sample_data_x = sample_data_x(sample_data_x<thresh_hold_x);
size_x = size(sample_data_x);
sample_data_y = sample_data_y(sample_data_y<thresh_hold_y);
size_y = size(sample_data_y);
while rem(size_x(1),1000) ~= 0
    thresh_hold_x = thresh_hold_x - 200;
    sample_data_x = sample_data_x(sample_data_x<thresh_hold_x);
    size_x = size(sample_data_x);
end
while rem(size_y(1),1000) ~= 0
    thresh_hold_y = thresh_hold_y - 300;
    sample_data_y = sample_data_y(sample_data_y<thresh_hold_y);
    size_y = size(sample_data_y);
end
sample_data = [sample_data_x sample_data_y];
load(test_data_input)
data = allUV;
thresh_hold_x = 70000;
thresh_hold_y = 120000;
test_data_x = data(:,1);
test_data_y = data(:,2);
test_data_x = test_data_x(test_data_x<thresh_hold_x);
size_x = size(test_data_x);
test_data_y = test_data_y(test_data_y<thresh_hold_y);
size_y = size(test_data_y);
while rem(size_x(1),1000) ~= 0
    thresh_hold_x = thresh_hold_x - 200;
    test_data_x = test_data_x(test_data_x<thresh_hold_x);
    size_x = size(test_data_x);
end
while rem(size_y(1),1000) ~= 0
    thresh_hold_y = thresh_hold_y - 300;
    test_data_y = test_data_y(test_data_y<thresh_hold_y);
    size_y = size(test_data_y);
end
    test_data = [test_data_x test_data_y];
    [row1,col1] = size(sample_data);
    size_sample = row1;
    [row2,col2] = size(test_data);
    size_test = row2;
    
    %Use the shorter video to compare the logner one
    if size_sample > size_test
        max_data = sample_data;
        min_data = test_data;
        max_size = size_sample;
        min_size = size_test;
    else
        max_data = test_data;
        min_data = sample_data;
        max_size = size_test;
        min_size = size_sample;
    end    
    
    %calculate the frame difference
    size_difference = (max_size - min_size)/1000;
    diff_data = [];
    
    
    for i = 1:size_difference
        
        %move the video frame per frame
        tmp_data = max_data((i-1)*1000+1:(i-1)*1000+min_size,:);
        
        %compare two histograms 
        diff_data = compareHists(tmp_data,min_data);
        sum_xy = sum(diff_data);
        diff_data = [diff_data sum_xy];
    end
    Result_list = min(diff_data);
end
