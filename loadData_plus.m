function [files data] = loadData_plus(path,extention)

% �������:
%    �������:
%        path       ͼ��·��
%        extention  ͼ���ʽ
%
%    �������:
%        data       ������ͼ����ݾ�����ݸ�ʽΪ imgsize * imgdeep * framenum 
%                   ͼ����ݳ��ȣ�һά�� * ͼ����ȣ�rgb�� * ͼ��֡��
%
%    ȫ�ֲ���:
%        g_height   ͼ��ĸ�
%        g_width    ͼ��Ŀ�
%        g_imgdeep  ͼ������

global g_height g_width g_imgdeep

if(path(end) ~= '/')
    path = [path '/'];
end

fprintf(1, 'Loading files from %s...\n', path);

files = dir([path '*.' extention]);
files = sort({files.name});

% Number of frames
% �ļ�������,��ϸ�ο�files���ļ���ʽ
frames = size(files, 2);

% Get the dimension of one picture
% ȡ����һ��ͼƬ�Է��������ڴ�
sizes = size(imread([path files{1}]));

% If we only have greyscale
if(length(sizes) == 2)
    sizes(3) = 1; % Pretend we have a third dimension
end 

data = zeros([sizes, frames], 'uint8');

for tt = 1:frames
    fprintf(1, 'Reading file %d: %s\r', tt, files{tt});
    im = imread([path files{tt}]);
    data(:, :, :, tt) = im;
end

