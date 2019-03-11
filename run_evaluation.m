clear all
close all
clc

gt_pa = './data/highway/groundtruth/';
gt_ft = 'png';


[files data] = loadData_plus(gt_pa, gt_ft);

gtim = data(:, :, :, 1000);
fgim = double(imread('./fgim.png'));

for i = 1:50
    fgim = medfilt2(fgim);
    
end


[TP FP FN TN] = evaluation_entry(fgim,gtim);

Re = TP/(TP + FN)
Pr = TP / (TP + FP)
Fm = (2*Pr*Re)/(Pr + Re)
