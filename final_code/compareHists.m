%function calculate histogram difference by subtraction
%input (feature video histogram, test video optical flow vector histogram)
%two histograms need has two rows, the first one represent the x direction
%the second one need to represent the y direction
%return a number represents histogram distance difference level
function s = compareHists(h1,h2)

s = sum(sum(sum(sqrt(h1).*sqrt(h2))));
