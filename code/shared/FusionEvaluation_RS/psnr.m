% function psnr = psnr(originalimg, restoredimg)
% %PSNR Summary of this function goes here
% %   Detailed explanation goes here
% %Peak Signal to Noise Ratio (PSNR)峰值信噪比
% 
% md = (originalimg - restoredimg).^2;
% mdsize = size(md);
% summation = 0;
% for  i = 1:mdsize(1)
%     for j = 1:mdsize(2)
%         summation = summation + abs(md(i,j));
%     end
% end
% 
% psnr = size(originalimg, 1) * size(originalimg, 2) * max(max(originalimg.^2))/summation;
% psnr = 10 * log10(psnr);
% %}
% 
% end
function psnr = psnr(ff1, ff2)
psnr2=0;
for i=1:3
    f1=ff1(:,:,i);
    f2=ff2(:,:,i);
    
%计算两幅图像的峰值信噪比
k = 8;
%k为图像是表示地个像素点所用的二进制位数，即位深。
fmax = 2.^k - 1;
a = fmax.^2;
e = double(f1) - double(f2);
[m, n] = size(e);
b = mean(sum(sum(e.^2)));
psnr1= 10*log10(m*n*a/b);
psnr2=psnr2+psnr1;
end
psnr=psnr2/3;
