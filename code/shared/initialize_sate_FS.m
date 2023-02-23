function initialize_sate_FS()
%% Quality Index Blocks
global Qblocks_size  bicubic flag_cut_bounds dim_cut thvalues printEPS ratio L;
global  folder_pan_noR folder_rgb_noR folder_nir_noR ;
global  file_path_pan_noR file_path_rgb_noR file_path_nir_noR ;
global savepath_F savepath_up savepath_rgb savepath_up_rgb;
global data count time ;
global sensor sate file_path_gt256; 
% global folder_nir1_256 folder_nir2_256   folder_RedEdge256  folder_yellow256  folder_coastal256
global file_path_nir1_256 file_path_nir2_256 file_path_RedEdge256 file_path_coastal256 file_path_yellow256
switch sate
    case {'wv2','wv'}
        sensor = 'WV2';
    case 'wv3'
        sensor = 'WV3';
    case 'wv3-8'
        sensor = 'WV3';
    case 'ik'
        sensor = 'IKONOS';
    case 'qb'
        sensor = 'QB';
    case 'geo'
        sensor = 'GeoEye1';
    otherwise
        sensor = 'none';
end

Qblocks_size = 32;
bicubic = 0;   %% Interpolator
flag_cut_bounds = 1; %% Cut Final Image
dim_cut = 11;
thvalues = 0;  %% Threshold values out of dynamic range
printEPS = 0;  %% Print Eps
ratio = 4;     %% Resize Factor
L = 11;        %% Radiometric Resolution


%% setting path
%% ∂¡»ÎÕºœÒ
if (strcmp(sate, 'ik'))
    folder_pan_noR = 'E:\remote sense image fusion\Source Images\IKONOS\ik_pan1024';    %   Pan image folder name
    folder_rgb_noR='E:\remote sense image fusion\Source Images\IKONOS\ik_rgb256';        %  MS image folder name
    folder_nir_noR='E:\remote sense image fusion\Source Images\IKONOS\ik_nir256';
    folder_gt256 = 'E:\remote sense image fusion\Source Images\IKONOS\ik_gt256';
    
    savepath_F = 'fused/IKONO\ik_4b_FS';   % fused image
    savepath_up = 'fused/IKONOS\ik_up_ms_FS';  % ms image
    savepath_rgb = 'fused/IKONO\ik_rgb_FS';   % gt image    
    savepath_up_rgb = 'fused/IKONO\ik_up_rgb_FS';
    
end
if (strcmp(sate, 'pl'))
    folder_pan_noR = 'E:\remote sense image fusion\Source Images\Pleiades\pl_pan1024';    %   Pan image folder name
    folder_rgb_noR='E:\remote sense image fusion\Source Images\Pleiades\pl_rgb256';        %  MS image folder name
    folder_nir_noR='E:\remote sense image fusion\Source Images\Pleiades\pl_nir256';  
    folder_gt256 = 'E:\remote sense image fusion\Source Images\Pleiades\pl_gt256';
    
    savepath_F = 'fused/Pleiades\pl_4b_FS';   % fused image
    savepath_up = 'fused/Pleiades\pl_up_ms_FS';  % ms image
    savepath_rgb = 'fused/Pleiades\pl_rgb_FS';   % gt image 
    savepath_up_rgb = 'fused/Pleiades\pl_up_rgb_FS'; 
    
end
if (strcmp(sate, 'qb'))
    folder_pan_noR = 'E:\remote sense image fusion\Source Images\QuickBird\2_PAN1024';    %   Pan image folder name
    folder_rgb_noR='E:\remote sense image fusion\Source Images\QuickBird\2_RGB256';        %  MS image folder name
    folder_nir_noR='E:\remote sense image fusion\Source Images\QuickBird\2_NIR256';
    folder_gt256 = 'E:\remote sense image fusion\Source Images\QuickBird\2_GT256';
    
    savepath_F = 'fused/QuickBird\qb_4b_FS';   % fused image
    savepath_up = 'fused/QuickBird\qb_up_ms_FS';  % ms image
    savepath_rgb = 'fused/QuickBird\qb_rgb_FS';   % gt image 
    savepath_up_rgb = 'fused/QuickBird\qb_up_rgb_FS'; 
end
% if (strcmp(sate, 'wv'))
%     folder_pan_noR = 'E:\remote sense image fusion\Source Images\wv_pan1024';    %   Pan image folder name
%     folder_rgb_noR='E:\remote sense image fusion\Source Images\wv_rgb256';        %  MS image folder name
%     folder_nir_noR='E:\remote sense image fusion\Source Images\wv_nir256';
%     
%     savepath_F = 'fused/wv_4b_FS';   % fused image
%     savepath_up = 'fused/wv_up_ms_FS';  % ms image
%     savepath_rgb = 'fused/wv_rgb_FS';   % gt image  
% end
if (strcmp(sate, 'wv2'))
    folder_pan_noR = 'E:\remote sense image fusion\Source Images\WorldView-2\wv2_pan1024';    %   Pan image folder name
    folder_rgb_noR='E:\remote sense image fusion\Source Images\WorldView-2\wv2_rgb256';        %  MS image folder name
    folder_nir_noR='E:\remote sense image fusion\Source Images\WorldView-2\wv2_nir256';    
     folder_gt256 = 'E:\remote sense image fusion\Source Images\WorldView-2\wv2_gt256';
   
    savepath_F = 'fused/WorldView-2\wv2_4b_FS';   % fused image
    savepath_up = 'fused/WorldView-2\wv2_up_ms_FS';  % ms image
    savepath_rgb = 'fused/WorldView-2\wv2_rgb_FS';   % gt image 
    savepath_up_rgb = 'fused/WorldView-2\wv2_up_rgb_FS';
end
if (strcmp(sate, 'wv3'))
    folder_pan_noR = 'E:\remote sense image fusion\Source Images\WorldView-3\wv3_pan1024';    %   Pan image folder name
    folder_rgb_noR = 'E:\remote sense image fusion\Source Images\WorldView-3\wv3_rgb256';        %  MS image folder name
    folder_nir_noR = 'E:\remote sense image fusion\Source Images\WorldView-3\wv3_nir256';
    
    savepath_F = 'fused/WorldView-3\wv3_4b_FS';   % fused image
    savepath_up = 'fused/WorldView-3\wv3_up_ms_FS';  % ms image
    savepath_rgb = 'fused/WorldView-3\wv3_rgb_FS';   % gt image 
    savepath_up_rgb = 'fused/WorldView-3\wv3_up_rgb_FS';
end

if (strcmp(sate, 'wv3-8'))
    folder_pan_noR = 'E:\remote sense image fusion\Source Images\WorldView3-8\pan1024';    %   Pan image folder name
    folder_rgb_noR = 'E:\remote sense image fusion\Source Images\WorldView3-8\rgb256';        %  MS image folder name
%     folder_nir_noR = 'E:\remote sense image fusion\Source Images\WorldView-3\wv3_nir256';
    folder_nir1_256 = 'E:\remote sense image fusion\Source Images\WorldView3-8\nir1-256';
    folder_nir2_256 = 'E:\remote sense image fusion\Source Images\WorldView3-8\nir2-256';
    folder_RedEdge256 = 'E:\remote sense image fusion\Source Images\WorldView3-8\RedEdge256';
    folder_yellow256 = 'E:\remote sense image fusion\Source Images\WorldView3-8\Yellow256';
    folder_coastal256 = 'E:\remote sense image fusion\Source Images\WorldView3-8\CoastalBlue256';
    
    savepath_F = 'fused/WorldView-3-8\wv3-8b-FS';   % fused image
    savepath_up = 'fused/WorldView-3-8\wv3-8-up-FS';  % ms image
    savepath_rgb = 'fused/WorldView-3-8\wv3-8-rgb-FS';   % gt image 
    savepath_up_rgb = 'fused/WorldView-3-8\wv3-8-rgb-up-FS';
    
    file_path_nir1_256 = dir(fullfile(folder_nir1_256,'*.tif'));   
    file_path_nir2_256 = dir(fullfile(folder_nir2_256,'*.tif')); 
    file_path_RedEdge256 = dir(fullfile(folder_RedEdge256,'*.tif')); 
    file_path_yellow256 = dir(fullfile(folder_yellow256,'*.tif')); 
    file_path_coastal256 = dir(fullfile(folder_coastal256,'*.tif')); 
end

if (strcmp(sate, 'geo'))
    folder_pan_noR = 'E:\remote sense image fusion\Source Images\GeoEye_1\PAN1024';    %   Pan image folder name
    folder_rgb_noR='E:\remote sense image fusion\Source Images\GeoEye_1\RGB256';        %  MS image folder name
    folder_nir_noR='E:\remote sense image fusion\Source Images\GeoEye_1\NIR256';
    folder_gt256 = 'E:\remote sense image fusion\Source Images\GeoEye_1\GT256';
    
    savepath_F = 'fused/GeoEye_1\geo_4b_FS';   % fused image
    savepath_up = 'fused/GeoEye_1\geo_up_ms_FS';  % ms image
    savepath_rgb = 'fused/GeoEye_1\geo_rgb_FS';   % gt image 
    savepath_up_rgb = 'fused/GeoEye_1\geo_up_rgb_FS';
end

file_path_pan_noR = dir(fullfile(folder_pan_noR,'*.tif'));   % Pan image path
file_path_rgb_noR = dir(fullfile(folder_rgb_noR,'*.tif'));     % MS image path


if (~strcmp(sate, 'wv3-8'))
    file_path_gt256 = dir(fullfile(folder_gt256,'*.tif')); 
    file_path_nir_noR = dir(fullfile(folder_nir_noR,'*.tif'));     % nir image path
end
% file_path_F4b = dir(fullfile(folder_nir_noR,'*.tif'));

data=cell(length(file_path_rgb_noR),7);  %data={'FILENAME','PSNR','CC','UIQI','RASE','RMSE','SAM','ERGAS'}
count=0;
time = zeros(1,length(file_path_rgb_noR));
end