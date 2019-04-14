%function using for histogram data analyzing
%input (test video optical flow vector histogram)
%histograms need has two rows, the first one represent the x direction
%the second one need to represent the y direction
%return a number represents the sum of the histogram

function sum_data = calculate_sum(sample_data)

%load the data and use the threshold to avoid image offset
load(sample_data)
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
sample_data_1 = [sample_data_x sample_data_y];

%sum the histogram
sum_data = sum(sum(sample_data_1));
end