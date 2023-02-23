% function [D_R,D_G,D_B]=definition1(RGB)
function D=definition1(RGB)
% 求一幅彩色图像各通道的清晰度
% 输入图像Im为三通道的彩色图像[]
% 值越大说明图像清晰度越高

[M,N,~]=size(RGB);
RGB=double(RGB);
g_R=0;             % r清晰度描述
g_G=0;             % g清晰度描述
g_B=0;             % b清晰度描述

r=RGB(:,:,1);
g=RGB(:,:,2);
b=RGB(:,:,3);

 for ii=1:M-1
    for jj=1:N-1
        g_R=g_R+sqrt((((r(ii+1,jj)-r(ii,jj))^2+(r(ii,jj+1)-r(ii,jj))^2))/2);
        g_G=g_G+sqrt((((g(ii+1,jj)-g(ii,jj))^2+(g(ii,jj+1)-g(ii,jj))^2))/2);
        g_B=g_B+sqrt((((b(ii+1,jj)-b(ii,jj))^2+(b(ii,jj+1)-b(ii,jj))^2))/2);

    end
 end
D_R=g_R/(M-1)/(N-1);
D_G=g_G/(M-1)/(N-1);
D_B=g_B/(M-1)/(N-1);
D = (D_R+D_G+D_B)/3;
%  fprintf('\n   R的清晰度为:%.4f\n   G的清晰度为:%.4f\n   B的清晰度为:%.4f\n   平均值为：%.4f\n',...
%      D_R, D_G, D_B, (D_R+D_G+D_B)/3);

%  fprintf('\n   平均清晰度为：%.4f\n', (D_R+D_G+D_B)/3); 