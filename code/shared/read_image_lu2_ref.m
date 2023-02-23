function [rgb256, gt256, mul64, pan256 ] = read_image_lu2_ref(num)

global folder_rgb256 folder_nir256 folder_pan256 folder_rgb64 folder_nir64 ;
global file_path_rgb256 file_path_nir256 file_path_pan256 file_path_rgb64 file_path_nir64 ;

rgb256 = imread(fullfile(folder_rgb256,file_path_rgb256(num).name));   % reference image
nir256 = imread(fullfile(folder_nir256,file_path_nir256(num).name));   % nir256 image
%im_gt=cat(3,im_rgb,im_nir);
%image_input1 = RSgenerate(im2double(im_gt),0,0);
pan256 = imread(fullfile(folder_pan256,file_path_pan256(num).name));  % Pan image
rgb64=imread(fullfile(folder_rgb64,file_path_rgb64(num).name));      % MS image
nir64=imread(fullfile(folder_nir64,file_path_nir64(num).name));     % nir64 image

mul64 = rgb64;
mul64(:,:,4) = nir64;

gt256 = rgb256;
gt256(:,:,4) = nir256;
end