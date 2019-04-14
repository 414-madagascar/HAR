%A program preprocess video data 
%output a optical flow vector histogram


%input a vidoe address(need to be images in order)
im_pa = 'D:/University/414/project/dataset/TableTennis/test_70fps';
im_ft = 'png';

%load data
[files,data] = loadData_plus(im_pa, im_ft);
[row_im,column_im,byte_im,frames_im] = size(data);

%output address
mkdir('D:/University/414/project/final_code/OF_his_test_Result')
uAll = [];
vAll = [];
allUV = [];

%fprintf(1, 'Start Handeling\r')
%for every two frames calculate the optical flow vector image
for i = 1:frames_im-1
    %first frame
    im1 = data(:, :, :, i);
    %second frame
    im2 = data(:, :, :, i+1);
    alpha=1;
    ite=100;
    uInitial = zeros(size(im1(:,:,1)));
    vInitial = zeros(size(im2(:,:,1)));
    displayFlow=1;
    displayImg=im1;
    im1 = uint8(im1);
    im2 = uint8(im2);
    
    %call the optical flow function
    [u, v] = HS(im1, im2, alpha, ite, uInitial, vInitial, displayFlow, displayImg);
    
    %use the threshold to remove short distance movement horizontaly
    threshold = 0.05;
    u = round(u);
    idx = u< threshold;
    u(idx) = 0;
    u_1001 = zeros(1001,1);
    result_u = HistRate(u);
    [row_u,column_u] = size(result_u);
    for o = 1:row_u
        u_1001(result_u(o,1) + 501) = result_u(o,2);
    end
    uAll = [uAll;u_1001];
    
    
    %use the threshold to remove short distance movement verticaly
    v = round(v);
    threshold = 0.05;
    for l = 1:row_im
        for m =1:column_im
            if abs(v(l,m))<threshold
                v(l,m)=0;
            end
        end
    end
    v_1001 = zeros(1001,1);
    result_v = HistRate(v);
    [row_v,column_v] = size(result_v);
    for q = 1:row_v
        v_1001(result_v(q,1) + 501) = result_v(q,2);
    end
    vAll = [vAll;v_1001];
end
allUV = [uAll vAll];

%output file name
filename = "OF_his_test_Result/TableTennis_70.mat";
save(filename,"allUV")
fprintf(1, 'Finish!\r');
