function [mul_noR, pan_noR ] = read_image_sate_FS(num)

global  folder_pan_noR folder_rgb_noR folder_nir_noR ;
global  file_path_pan_noR file_path_rgb_noR file_path_nir_noR ;
% global folder_nir1_256 folder_nir2_256   folder_RedEdge256  folder_yellow256  folder_coastal256
global sate
global file_path_gt256 
global file_path_mat128 file_path_gray128 file_path_mat32;
% rgb256 = imread(fullfile(folder_rgb256,file_path_rgb256(num).name));   % reference image
% nir256 = imread(fullfile(folder_nir256,file_path_nir256(num).name));   % nir256 image
%im_gt=cat(3,im_rgb,im_nir);
%image_input1 = RSgenerate(im2double(im_gt),0,0);

if (strcmp(sate, 'wv3-8'))
    data = load(fullfile(file_path_gt256(num).folder,file_path_gt256(num).name));
    mul_noR = data.gt256;
    pan_noR = imread(fullfile(file_path_pan_noR(num).folder,file_path_pan_noR(num).name));  % Pan image
elseif (strcmp(sate, 'tg'))    
    data = load(fullfile(file_path_mat128(num).folder,file_path_mat128(num).name));
    mul_noR = data.image;
    pan_noR = 0;  % Pan image 
else        
    mul_noR=imread(fullfile(file_path_gt256(num).folder,file_path_gt256(num).name));      % MS image\
    pan_noR = imread(fullfile(file_path_pan_noR(num).folder,file_path_pan_noR(num).name));  % Pan image
end
% mul_noR = Tiff(fullfile(file_path_gt256(num).folder,file_path_gt256(num).name),'r');

% gt256 = rgb256;
% gt256(:,:,4) = nir256;

end