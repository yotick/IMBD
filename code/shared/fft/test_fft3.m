%% freqz2 P90 ÔöÇ¿´¹Ö±±ßÔµ laplacian
clc
clear
[imgMul_u8, imgPan_u8, org_img_u8] = read_image_4C('se');
% f_ori = imread('Fig0409(a).tif');
f = reshape(imgPan_u8,[1024,64]);
% f = imgPan_u8;
% imshowMy(f)
% mul_pad = m_pad(imgMul_u8(:,:,1),1024,1024);
R1 = rand(1024,1024);
R2 = rand(1024,1024);
mul_plus = double(R1) + ones(1024,1024);
f_pad = double(m_pad(f,1024,1024));
 
F = fft2(imgPan_u8);
% S = fftshift(log(1+abs(F)));
% S = gscale(S);
% imshowMy(S)

h = fspecial('laplacian',0);
% figure,freqz2(h);
% size_h = size(temp)
% [m,n] = size(f);
% PQ = paddedsize(size(f));
PQ = size(imgPan_u8);
H = freqz2(h,PQ(1),PQ(2));
H1 = ifftshift(H); 
% figure,mesh(abs(H1(1:20:1200,1:20:1200)))

% imshow(abs(H),[])
% imshow(abs(H1),[])

% gs_pad = imfilter(double(f_pad),h);
% gs_pad = imfilter(double(gs_pad),h);
% gf = dftfilt(imgPan_u8,H1);
A = H1.*H1.*F;
B = H1.*H1;
gf = ifft2(A/B);
gf = real(gf);
% gf_pad = fft2(R1* f_pad)/(fft2(R2));
% gf_pad = ifft2(gf_pad);
% gf_pad = real(gf_pad);

% gs_div = R1*f_pad/(R2);


% gs = g(1:size(f, 1), 1:size(f, 2));
% gs = gs_div(1:1024, 1:64);
% gs = reshape(gs, 256,256);
% gf = gf_pad(1:1024, 1:64);
% gf = reshape(gf, 256,256);

% imshow(gs,[])
% title('space')
figure,imshow(gf,[])
title('frequence')

% figure, imshow(abs(gs),[])
% title('abs space')
figure, imshow(abs(gf),[])
 title('abs frequence')

% imshow(abs(gs) > 0.2*abs(max(gs(:))))
% imshow(abs(gf) > 0.2*abs(max(gf(:))))