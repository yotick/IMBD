function [rgb256, gt256, mul64, pan256 ] = read_image_sate_RS(num)

global folder_rgb256 folder_nir256 folder_pan256 folder_rgb64 folder_nir64 folder_gt256 folder_ik64;
global file_path_rgb256 file_path_nir256 file_path_pan256 file_path_rgb64 file_path_nir64 file_path_ik64;
global file_path_gt256;
global sate;
global file_path_nir1_256 file_path_nir2_256 file_path_RedEdge256 file_path_coastal256 file_path_yellow256
global file_path_nir1_64 file_path_nir2_64 file_path_RedEdge64 file_path_coastal64 file_path_yellow64 file_path_mul64
global file_path_mat128 file_path_gray128 file_path_mat32 folder_mat32;

% 
% rgb64 = imread( strcat(file_path_rgb64(num).folder,'/',file_path_rgb64(num).name));  % MS image

pan256 = imread(fullfile(folder_pan256,file_path_pan256(num).name));
rgb256 = imread(fullfile(folder_rgb256,file_path_rgb256(num).name));
% rgb256 = 0;

if (strcmp(sate, 'tg'))
    data1 = load(fullfile(file_path_mat128(num).folder,file_path_mat128(num).name));    
    gt256 = data1.image;
    data2 = load(fullfile(file_path_mat32(num).folder,file_path_mat32(num).name));
    mul64 = data2.mul32;
end
if (strcmp(sate, 'wv3-8'))
   % % fullfile and strcat has the same function
    nir1_256 = imread( fullfile(file_path_nir1_256(num).folder,file_path_nir1_256(num).name));   
%     nir1_64 = imread( strcat(file_path_nir1_64(num).folder,'/',file_path_nir1_64(num).name)); 
    nir2_256 = imread( strcat(file_path_nir2_256(num).folder,'/',file_path_nir2_256(num).name)); 
%     nir2_64 = imread( strcat(file_path_nir2_64(num).folder,'/',file_path_nir2_64(num).name));
    RedEdge256 = imread( strcat(file_path_RedEdge256(num).folder,'/',file_path_RedEdge256(num).name));
%     RedEdge64 = imread( strcat(file_path_RedEdge64(num).folder,'/',file_path_RedEdge64(num).name));
    yellow256 = imread( strcat(file_path_yellow256(num).folder,'/',file_path_yellow256(num).name));
%     yellow64 = imread( strcat(file_path_yellow64(num).folder,'/',file_path_yellow64(num).name));
    coastal256 = imread( strcat(file_path_coastal256(num).folder,'/',file_path_coastal256(num).name));
%     coastal64 = imread( strcat(file_path_coastal64(num).folder,'/',file_path_coastal64(num).name));
    
    gt256 = rgb256;
    gt256(:,:,4) = nir1_256;
    gt256(:,:,5) = nir2_256;
    gt256(:,:,6) = RedEdge256;
    gt256(:,:,7) = yellow256;
    gt256(:,:,8) = coastal256;
    
    % when creat gt256, the following should be anotationed 
    data = load(fullfile(file_path_mul64(num).folder,file_path_mul64(num).name));
    mul64 = uint8(data.mul64);

%     mul64 = 0;
%     mul64(:,:,4) = nir1_64;
%     mul64(:,:,5) = nir2_64;
%     mul64(:,:,6) = RedEdge64;
%     mul64(:,:,7) = yellow64;
%     mul64(:,:,8) = coastal64;
elseif (~strcmp(sate, 'tg'))
    nir256 = imread(fullfile(folder_nir256,file_path_nir256(num).name));
    nir64 = imread(fullfile(folder_nir64, file_path_nir64(num).name));
    
    rgb64 = imread(fullfile(file_path_rgb64(num).folder, file_path_rgb64(num).name));  % MS image
    mul64 = rgb64;
    mul64(:,:,4) = nir64;
    gt256 = rgb256;
    gt256(:,:,4) = nir256;
end

end