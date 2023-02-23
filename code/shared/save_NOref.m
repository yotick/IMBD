function save_NOref(fused_4b, ms_up, fused_rgb, num)

global  file_path_rgb_noR savepath_F savepath_up savepath_rgb file_path_F4b;


% savepath_gt = 'E:\remote sense image fusion\my code_change\code2_lu\4_channal/img_gt/gt256';   % gt image


file_path_F4b = dir(fullfile(savepath_F,'*.tif'));
% file_path_gt = dir(fullfile(savepath_gt,'*.tif'));

imwrite(fused_4b,fullfile(savepath_F,file_path_rgb_noR(num).name));
imwrite(ms_up,fullfile(savepath_up,file_path_rgb_noR(num).name));
%     imwrite(ORM,fullfile(savepath_gt,filepathrgb(num).name));
imwrite(fused_rgb, fullfile(savepath_rgb,file_path_rgb_noR(num).name));
end