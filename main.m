
im_pa = './Colour';
im_ft = 'png';
[files,data] = loadData_plus(im_pa, im_ft);
data = double(data);
[row_im,column_im,byte_im,frames_im] = size(data);

mkdir('./OF_his_Result/')

uAll = [];
vAll = [];
allUV = [];

for i = 1:frames_im-1
    fprintf(1, 'Handeling Frame %d and %d\r', i,i+1);
    im1 = data(:, :, :, i);
    im2 = data(:, :, :, i+1);
    alpha=1;
    ite=100;
    uInitial = zeros(size(im1(:,:,1)));
    vInitial = zeros(size(im2(:,:,1)));
    displayFlow=1;
    displayImg=im1;
    im1 = uint8(im1);
    im2 = uint8(im2);
    [u, v] = HS(im1, im2, alpha, ite, uInitial, vInitial, displayFlow, displayImg);

    %u
    u = round(u);
    threshold = 0.05;
    for j = 1:row_im
        for k =1:column_im
            if abs(u(j,k))<threshold
                u(j,k)=0;
            end
        end
    end
    u_1001 = zeros(1001,1);
    result_u = HistRate(u);
    [row_u,column_u] = size(result_u);
    for o = 1:row_u
        u_1001(result_u(o,1) + 501) = result_u(o,2);
    end
    uAll = [uAll;u_1001];
    
    %v
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
filename = "OF_his_Result/Boxing_p7&p8.mat";
save(filename,"allUV")
fprintf(1, 'Finish!\r');
