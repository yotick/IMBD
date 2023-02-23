function save_sate_RS(fused, ms_up, fused_rgb, num)
global file_path_F4b file_path_gt savepath_gt savepath_F savepath_up savepath_rgb;
global file_path_rgb256  sate;
global curr_d gt256;

cd(curr_d);

if (strcmp(sate, 'wv3-8'))
    if(isa(fused,'uint8'))
        save(strcat(savepath_F,'/',file_path_rgb256(num).name(1:end-4),'.mat'), 'fused');
        save(strcat(savepath_up,'/',file_path_rgb256(num).name(1:end-4),'.mat'), 'ms_up');
    else
        fused = uint8(fused*255);
        save(strcat(savepath_F,'/',file_path_rgb256(num).name(1:end-4),'.mat'), 'fused');
        save(strcat(savepath_up,'/',file_path_rgb256(num).name(1:end-4),'.mat'), 'ms_up');
    end
    
elseif (strcmp(sate, 'tg'))
    save(strcat(savepath_F,'/',file_path_rgb256(num).name(1:end-4),'.mat'), 'fused');
    save(strcat(savepath_up,'/',file_path_rgb256(num).name(1:end-4),'.mat'), 'ms_up');
    % elseif (strcmp(sate, 'tg'))
    %     if(isa(fused,'uint8'))
    %         save(strcat(savepath_F,'/',file_path_rgb256(num).name(1:end-4),'.mat'), 'fused');
    %         save(strcat(savepath_up,'/',file_path_rgb256(num).name(1:end-4),'.mat'), 'ms_up');
    %     else
    %         fused = uint8(fused*255);
    %         save(strcat(savepath_F,'/',file_path_rgb256(num).name(1:end-4),'.mat'), 'fused');
    %     end
else
    imwrite(fused,fullfile(savepath_F,file_path_rgb256(num).name));
    imwrite(ms_up,fullfile(savepath_up,file_path_rgb256(num).name));
    % imwrite(gt256,fullfile(savepath_gt,file_path_rgb256(num).name));
end

imwrite(fused_rgb, fullfile(savepath_rgb,file_path_rgb256(num).name));
end