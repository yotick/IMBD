function T = quality_eval_sate_FS2()

global  folder_pan_noR folder_rgb_noR folder_nir_noR ;
global  file_path_pan_noR file_path_rgb_noR file_path_nir_noR ;
global  savepath_F savepath_up ;
global  thvalues  ratio L im_tag sensor;
global  time data num curr_d flagQNR;

im_tag = 'China';
eval_times = 0;
% for  i= 1: length(file_path_F4b)
for  i= 1: num
% for  i= 1: num
    cd(curr_d);
    eval_times = eval_times + 1
    im_F = imread(fullfile(savepath_F,file_path_rgb_noR(i).name));
    %     im_gt=imread(fullfile(savepath_gt,file_path_gt(i).name));
    m_up=imread(fullfile(savepath_up,file_path_rgb_noR(i).name));
    im_pan=imread(fullfile(folder_pan_noR,file_path_pan_noR(i).name));
    rgb_noR=imread(fullfile(folder_rgb_noR,file_path_rgb_noR(i).name));      % MS image
    nir_noR=imread(fullfile(folder_nir_noR,file_path_nir_noR(i).name));     % nir64 image    
    mul_noR = rgb_noR;
    mul_noR(:,:,4) = nir_noR;

%     rgb_noR = imread('Nanjing_20141229_RGB_tif_R31C25.tif');
%     nir_noR = imread('Nanjing_20141229_NIR_tif_R31C25.tif');
%     pan_noR = imread('Nanjing_20141229_PAN_tif_R31C25.tif');
%     mul_noR(:,:,1:3) = rgb_noR;
%     mul_noR(:,:,4) = nir_noR;
    
%     im_F = im2double(im_F);
%     im_pan= im2double(im_pan);
%     mul_noR= im2double(mul_noR);
%     m_up = im2double(m_up);
    
    [D_lambda_Segm,D_S_Segm,QNRI_Segm] = indexes_evaluation_FS2(im_F,mul_noR,im_pan,...
    L,thvalues,m_up,sensor,ratio, flagQNR);

    
%     [peaksnr] = psnr(im_F,im_gt);
    data{i,1}=file_path_rgb_noR(i).name;
    
    data{i,2}=roundn(D_lambda_Segm,-4);
    data{i,3}=roundn(D_S_Segm,-4);
    data{i,4}=roundn(QNRI_Segm,-4);
%     data{i,5}=roundn(SAM_Segm,-4);
%     data{i,6}=roundn(SCC_Segm,-4);
    data{i,7} = roundn(time(i),-2);
end
j = num +1;
data{j,1}='average';
data{j,2}=roundn(mean(cell2mat(data(1:j-1, 2))),-4);
data{j,3}=roundn(mean(cell2mat(data(1:j-1, 3))),-4);
data{j,4}=roundn(mean(cell2mat(data(1:j-1, 4))),-4);
data{j,5}=roundn(mean(cell2mat(data(1:j-1, 5))),-4);
data{j,6}=roundn(mean(cell2mat(data(1:j-1, 6))),-4);
data{j,7}=roundn(mean(cell2mat(data(1:j-1, 7))),-2);

T = cell2table(data,'VariableNames',{'FILENAME' 'D_lambda' 'D_S' 'HQNR' 'SAM'  'SCC' 'time'});
end