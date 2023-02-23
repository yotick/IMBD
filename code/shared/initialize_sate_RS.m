function initialize_sate_RS()
%% Quality Index Blocks
global Qblocks_size  bicubic flag_cut_bounds dim_cut thvalues printEPS ratio L;
global folder_rgb256 folder_nir256 folder_pan256 folder_rgb64 folder_nir64 folder_gt256 folder_ik64;
global file_path_rgb256 file_path_nir256 file_path_pan256 file_path_rgb64 file_path_nir64 file_path_ik64;
global file_path_gt256;
global savepath_gt savepath_F savepath_up savepath_rgb ;
global data count time ;
global sensor sate mu;

switch sate
    case {'wv2','wv'}
        sensor = 'WV2';
        mu = 0.78;
    case 'wv3'
        sensor = 'WV3';
    case 'ik'
        sensor = 'IKONOS';
        mu = 0.82;
    case 'qb'
        sensor = 'QB';
    case 'pl'
        sensor = 'none';
        mu = 0.86;
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
    folder_rgb256 = 'E:\remote sense image fusion\Source Images\IKONO\ik_rgb256';    %  RBG image folder name
    folder_nir256 = 'E:\remote sense image fusion\Source Images\IKONO\ik_nir256';
    % folder_pan_ori = 'ik_pan256' ;
    folder_gt256 = 'E:\remote sense image fusion\Source Images\IKONO\ik_gt256';
    folder_nir64 = 'E:\remote sense image fusion\Source Images\IKONO\ik_nir64';
    folder_rgb64 = 'E:\remote sense image fusion\Source Images\IKONO\ik_rgb64';
    folder_pan256 = 'E:\remote sense image fusion\Source Images\IKONO\ik_pan256';
    
    savepath_F = 'fused/IKONO\ik_4b';   % fused image
    savepath_up = 'fused/IKONO\ik_up_ms';  % ms image
    savepath_gt = folder_gt256;   % gt image
    savepath_rgb = 'fused/IKONO\ik_rgb';   % gt image
end
if (strcmp(sate, 'pl'))
    folder_rgb256 = 'E:\remote sense image fusion\Source Images\Pleiades\pl_rgb256';    %  RBG image folder name
    folder_nir256 = 'E:\remote sense image fusion\Source Images\Pleiades\pl_nir256';
    % folder_pan_ori = 'ik_pan256' ;
    folder_rgb64 = 'E:\remote sense image fusion\Source Images\Pleiades\pl_rgb64';
    folder_nir64 = 'E:\remote sense image fusion\Source Images\Pleiades\pl_nir64';
    folder_pan256 = 'E:\remote sense image fusion\Source Images\Pleiades\pl_pan256';
    folder_gt256 = 'E:\remote sense image fusion\Source Images\Pleiades\pl_gt256' ;
    
    savepath_F = 'fused/Pleiades\pl_4b';   % fused image
    savepath_up = 'fused/Pleiades\pl_up_ms';  % ms image
    savepath_gt = folder_gt256;   % gt image
    savepath_rgb = 'fused/Pleiades\pl_rgb';   % gt image
end
if (strcmp(sate, 'qb'))
    folder_rgb256 = 'E:\remote sense image fusion\Source Images\QuickBird\2_RGB256';    %  RBG image folder name
    folder_nir256 = 'E:\remote sense image fusion\Source Images\QuickBird\2_NIR256';
    % folder_pan_ori = 'ik_pan256' ;
    folder_rgb64 = 'E:\remote sense image fusion\Source Images\QuickBird\2_RGB64';
    folder_nir64 = 'E:\remote sense image fusion\Source Images\QuickBird\2_NIR64';
    folder_pan256 = 'E:\remote sense image fusion\Source Images\QuickBird\2_PAN256';
    folder_gt256 = 'E:\remote sense image fusion\Source Images\QuickBird\2_GT256' ;
    
    savepath_F = 'fused/QuickBird\qb_4b';   % fused image
    savepath_up = 'fused/QuickBird\qb_up_ms';  % ms image
    savepath_gt = folder_gt256;   % gt image
    savepath_rgb = 'fused/QuickBird\qb_rgb';   % gt image
end
% if (strcmp(sate, 'wv'))
%     folder_rgb256 = 'E:\remote sense image fusion\Source Images\wv_rgb256';    %  RBG image folder name
%     folder_nir256 = 'E:\remote sense image fusion\Source Images\wv_nir256';
%     % folder_pan_ori = 'ik_pan256' ;
%     folder_rgb64 = 'E:\remote sense image fusion\Source Images\wv_rgb64';
%     folder_nir64 = 'E:\remote sense image fusion\Source Images\wv_nir64';
%     folder_pan256 = 'E:\remote sense image fusion\Source Images\wv_pan256';
%     folder_gt256 = 'E:\remote sense image fusion\Source Images\wv_gt256' ;
%
%     savepath_F = 'fused/wv_4b';   % fused image
%     savepath_up = 'fused/wv_up_ms';  % ms image
%     savepath_gt = folder_gt256;   % gt image
%     savepath_rgb = 'fused/wv_rgb';   % gt image
% end
if (strcmp(sate, 'wv2'))
    folder_rgb256 = 'E:\remote sense image fusion\Source Images\WorldView-2\wv2_rgb256';    %  RBG image folder name
    folder_nir256 = 'E:\remote sense image fusion\Source Images\WorldView-2\wv2_nir256';
    % folder_pan_ori = 'ik_pan256' ;
    folder_rgb64 = 'E:\remote sense image fusion\Source Images\WorldView-2\wv2_rgb64';
    folder_nir64 = 'E:\remote sense image fusion\Source Images\WorldView-2\wv2_nir64';
    folder_pan256 = 'E:\remote sense image fusion\Source Images\WorldView-2\wv2_pan256';
    folder_gt256 = 'E:\remote sense image fusion\Source Images\WorldView-2\wv2_gt256' ;
    
    savepath_F = 'fused/WorldView-2\wv2_4b';   % fused image
    savepath_up = 'fused/WorldView-2\wv2_up_ms';  % ms image
    savepath_gt = folder_gt256;   % gt image
    savepath_rgb = 'fused/WorldView-2\wv2_rgb';   % gt image
end
if (strcmp(sate, 'wv3'))
    folder_rgb256 = 'E:\remote sense image fusion\Source Images\WorldView-3\wv3_rgb256';    %  RBG image folder name
    folder_nir256 = 'E:\remote sense image fusion\Source Images\WorldView-3\wv3_nir256';
    % folder_pan_ori = 'ik_pan256' ;
    folder_rgb64 = 'E:\remote sense image fusion\Source Images\WorldView-3\wv3_rgb64';
    folder_nir64 = 'E:\remote sense image fusion\Source Images\WorldView-3\wv3_nir64';
    folder_pan256 = 'E:\remote sense image fusion\Source Images\WorldView-3\wv3_pan256';
    folder_gt256 = 'E:\remote sense image fusion\Source Images\WorldView-3\wv3_gt256' ;
    
    savepath_F = 'fused/WorldView-3\wv3_4b';   % fused image
    savepath_up = 'fused/WorldView-3\wv3_up_ms';  % ms image
    savepath_gt = folder_gt256;   % gt image
    savepath_rgb = 'fused/WorldView-3\wv3_rgb';   % gt image
end
if (strcmp(sate, 'geo'))
    folder_rgb256 = 'E:\remote sense image fusion\Source Images\GeoEye_1\RGB256';    %  RBG image folder name
    folder_nir256 = 'E:\remote sense image fusion\Source Images\GeoEye_1\NIR256';
    % folder_pan_ori = 'ik_pan256' ;
    folder_rgb64 = 'E:\remote sense image fusion\Source Images\GeoEye_1\RGB64';
    folder_nir64 = 'E:\remote sense image fusion\Source Images\GeoEye_1\NIR64';
    folder_pan256 = 'E:\remote sense image fusion\Source Images\GeoEye_1\PAN256';
    folder_gt256 = 'E:\remote sense image fusion\Source Images\GeoEye_1\GT256' ;
    
    savepath_F = 'fused/GeoEye_1\geo_4b';   % fused image
    savepath_up = 'fused/GeoEye_1\geo_up_ms';  % ms image
    savepath_gt = folder_gt256;   % gt image
    savepath_rgb = 'fused/GeoEye_1\geo_rgb';   % gt image
end

file_path_rgb256 = dir(fullfile(folder_rgb256,'*.tif'));     % RGB image path
file_path_nir256 = dir(fullfile(folder_nir256,'*.tif'));
file_path_gt256 = dir(fullfile(folder_gt256,'*.tif'));

file_path_rgb64 = dir(fullfile(folder_rgb64,'*.tif'));     % RGB image path
file_path_nir64 = dir(fullfile(folder_nir64,'*.tif'));     % RGB image path

file_path_pan256 = dir(fullfile(folder_pan256,'*.tif'));

data=cell(length(file_path_rgb256),15);  %data={'FILENAME','PSNR','CC','UIQI','RASE','RMSE','SAM','ERGAS'}
count=0;
time = zeros(1,length(file_path_rgb256));
end