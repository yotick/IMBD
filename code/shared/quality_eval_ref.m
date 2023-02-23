function  T = quality_eval_ref()

global file_path_F4b file_path_gt savepath_gt savepath_F savepath_up ;
global file_path_rgb256 folder_pan256 file_path_pan256;
global Qblocks_size   flag_cut_bounds dim_cut thvalues  ratio L; 
global time data num;

% for  i= 1: length(file_path_F4b)   
for  i= 1: num
%     %     count=count+1
    im_F = imread(fullfile(savepath_F,file_path_rgb256(i).name));
    im_gt=imread(fullfile(savepath_gt,file_path_rgb256(i).name));
    im_M=imread(fullfile(savepath_up,file_path_rgb256(i).name));
    im_pan256=imread(fullfile(folder_pan256,file_path_pan256(i).name));
    
    im_F = im2double(im_F);
    im_pan256= im2double(im_pan256);
    im_M = im2double(im_M);
    im_gt= im2double(im_gt);
    
%     [D1,D2,QNR]=getQNR4(im_gt,im_pan256,im_F);
    [Q_avg_Segm, SAM_Segm, ERGAS_Segm, SCC_GT_Segm, Q_Segm] = indexes_evaluation(im_F,im_gt,ratio,...
    L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

    [peaksnr] = psnr(im_F,im_gt);
    data{i,1}=file_path_rgb256(i).name;
    data{i,2}=roundn(peaksnr,-4);
    data{i,3}=roundn(CC4(im_gt,im_F),-4);
    data{i,4}=roundn(UIQI4(im_gt,im_F),-4);
    data{i,5}=roundn(RASE(im_gt,im_F),-4);
    data{i,6}=roundn(RMSE(im_gt,im_F),-4);
    data{i,7}=roundn(SAM4(im_gt,im_F),-4);
    data{i,8}=roundn(ERGAS(im_gt,im_F),-4);
    
    data{i,9}=roundn(Q_avg_Segm,-4);
    data{i,10}=roundn(SAM_Segm,-4);
    data{i,11}=roundn(ERGAS_Segm,-4);
    data{i,12}=roundn(SCC_GT_Segm,-4);
    data{i,13}=roundn(Q_Segm,-4);
    data{i,14} = roundn(time(i),-2);
end
j = num +1;
data{j,1}='average';
data{j,2}=roundn(mean(cell2mat(data(2:j-1, 2))),-4);
data{j,3}=roundn(mean(cell2mat(data(2:j-1, 3))),-4);
data{j,4}=roundn(mean(cell2mat(data(2:j-1, 4))),-4);
data{j,5}=roundn(mean(cell2mat(data(2:j-1, 5))),-4);
data{j,6}=roundn(mean(cell2mat(data(2:j-1, 6))),-4);
data{j,7}=roundn(mean(cell2mat(data(2:j-1, 7))),-4);
data{j,8}=roundn(mean(cell2mat(data(2:j-1, 8))),-4);
data{j,9}=roundn(mean(cell2mat(data(2:j-1, 9))),-4);
data{j,10}=roundn(mean(cell2mat(data(2:j-1,10))),-4);
data{j,11}=roundn(mean(cell2mat(data(2:j-1,11))),-4);
data{j,12}=roundn(mean(cell2mat(data(2:j-1,12))),-4);
data{j,13}=roundn(mean(cell2mat(data(2:j-1,13))),-4);
data{j,14}=roundn(mean(cell2mat(data(2:j-1,14))),-2);
T = cell2table(data,'VariableNames',{'FILENAME' 'PSNR' 'CC' 'UIQI' 'RASE' 'RMSE' 'SAM' 'ERGAS'...
    'Q_UIQI' 'SAM2'  'ERGAS2' 'SCC' 'Q2n' 'time'});
end