function [mul_noR, pan_noR ] = read_image_lu2_NOref(num)

global  folder_pan_noR folder_rgb_noR folder_nir_noR ;
global  file_path_pan_noR file_path_rgb_noR file_path_nir_noR ;

% rgb256 = imread(fullfile(folder_rgb256,file_path_rgb256(num).name));   % reference image
% nir256 = imread(fullfile(folder_nir256,file_path_nir256(num).name));   % nir256 image
%im_gt=cat(3,im_rgb,im_nir);
%image_input1 = RSgenerate(im2double(im_gt),0,0);
pan_noR = imread(fullfile(folder_pan_noR,file_path_pan_noR(num).name));  % Pan image
rgb_noR=imread(fullfile(folder_rgb_noR,file_path_rgb_noR(num).name));      % MS image
nir_noR=imread(fullfile(folder_nir_noR,file_path_nir_noR(num).name));     % nir64 image

mul_noR = rgb_noR;
mul_noR(:,:,4) = nir_noR;
% gt256 = rgb256;
% gt256(:,:,4) = nir256;


end