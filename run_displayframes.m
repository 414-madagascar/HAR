clear all
close all
clc

im_pa = './dataset/Boxing/Boxing_p5&p6/Colour';
im_ft = 'png';

[files data] = loadData_plus(im_pa, im_ft);
data = double(data);

[row_im column_im byte_im frames_im] = size(data);

sum_img = zeros(row_im,column_im);

for i = 1:frames_im
    im = data(:, :, :, i);
    sum_img = sum_img + im;
    
%    displayMatrixImage(i, 1, 2, im, im)
%   displayMatrixImage(i, 1, 3, im, im, im)
%   displayMatrixImage(i, 2, 2, im, im, im, im)

end

back_img = sum_img / frames_im;
%displayMatrixImage(i, 1, 2, back_img, back_img)
mkdir('./dataset/Boxing/Boxing_p5&p6/Background_Result/')
for i = 1:i
    im = data(:, :, :, i);
    result_img = im - back_img;
    imwrite(uint8(result_img),sprintf('./dataset/Boxing/Boxing_p5&p6/Background_Result/result_image%d.png',i))
    %imwrite(im,sprintf('./dataset/Boxing/Boxing_p5&p6/Result/or_image%d.png',i))
    %imwrite(result_img.cdata, '/dataset/Boxing/Boxing_p5&p6/result/result_image%s.png',i);
%    displayMatrixImage(i, 1, 2, im, im)
%   displayMatrixImage(i, 1, 3, im, im, im)
%   displayMatrixImage(i, 2, 2, im, im, im, im)

end

thou_img = data(:, :, :, 500);
prox_img = thou_img - back_img;
[row col something] = size(prox_img);
final_img = zeros(row,col);
threshold_1 = 29;
for i = 1:row
    for j = 1:col
        if prox_img(i,j) > threshold_1
            final_img(i,j) = 255;
        else
            final_img(i,j) = 0;
        end
    end
end
displayMatrixImage(1000, 2, 2, thou_img, back_img, result_img, final_img)



