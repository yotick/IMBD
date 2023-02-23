function initialize_lu2_ref()
%% Quality Index Blocks
global Qblocks_size  bicubic flag_cut_bounds dim_cut thvalues printEPS ratio L; 
global folder_rgb256 folder_nir256 folder_pan256 folder_rgb64 folder_nir64 ;
global file_path_rgb256 file_path_nir256 file_path_pan256 file_path_rgb64 file_path_nir64 ;
global data count time ;
global sensor sate;

switch sate
    case {'wv2','wv'}
        sensor = 'WV2';
    case 'wv3'
        sensor = 'WV3';
    case 'ik'
        sensor = 'IKONOS';
    case 'qb'
        sensor = 'QB';
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

folder_rgb256 = 'E:\remote sense image fusion\my code_change\code2_lu\4_channal/RGB256';    %  RBG image folder name
folder_nir256 = 'E:\remote sense image fusion\my code_change\code2_lu\4_channal/NIR256';
folder_pan256 = 'E:\remote sense image fusion\my code_change\code2_lu\4_channal/pan256';    %   Pan image folder name
folder_rgb64='E:\remote sense image fusion\my code_change\code2_lu\4_channal/Mul64';        %  MS image folder name
folder_nir64='E:\remote sense image fusion\my code_change\code2_lu\4_channal/NIR64';

file_path_rgb256 = dir(fullfile(folder_rgb256,'*.tif'));     % RGB image path
file_path_nir256 = dir(fullfile(folder_nir256,'*.tif'));
file_path_pan256 = dir(fullfile(folder_pan256,'*.tif'));   % Pan image path
%filepathpan128 = dir(fullfile(folderpan128,'*.tif'));
file_path_rgb64 = dir(fullfile(folder_rgb64,'*.tif'));     % MS image path
file_path_nir64 = dir(fullfile(folder_nir64,'*.tif'));     % nir image path

data=cell(length(file_path_rgb256),14);  %data={'FILENAME','PSNR','CC','UIQI','RASE','RMSE','SAM','ERGAS'}
count=0;
time = zeros(length(file_path_rgb256));
end