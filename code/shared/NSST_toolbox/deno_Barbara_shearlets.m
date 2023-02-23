%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This is a script for testing denoising  
%   using (Fourier based) shearlet transform
%   test image: Lena
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function deno_Barbara_shearlets
clf;
% original image
im = imread('barbara.jpg','jpg');
im = double(im);
% create noisy image
nimg = GWNoisy2(im,20);
disp( 'Displaying the input image...');
clf;
% display noisy image and original image
subplot(1,2,1), imagesc(im, [0, 255]);
title( 'Input image' ) ;
axis image off;
subplot(1,2,2), imagesc(nimg, [0, 255]);
title( 'Noisy image' );
axis image off;
colormap(gray);
input( 'Press Enter key to continue...' ) ;
disp(' ');
disp('Computing shearing filters...');
disp(' ');
tic;
shear =shearing_filters_Myer([30 30 36 36],[3 3 4 4],512);
toc;
disp('Computing l^2 norm of shearlets...');
disp(' ');
tic;
E = com_norm('maxflat',size(im),shear);
toc;

% Take translation invariant shearlet transform with Hard Thresholding. 
disp('Taking translation invariant shearlet transform for denoising')
disp(' ');
imrec = shear_denoise(nimg,20,shear,E,[2.5 2.5 2.5 2.5 3.1]);

psnr = 20*log10(255/(1/512*norm(double(im(:))-imrec(:))));
psnr1 = 20*log10(255/(1/512*norm(double(im(:))-nimg(:))));

input( 'Press Enter key to continue...' ) ;
disp(' ');

% display results
clf;
disp('Displaying results...') ;
subplot(1,3,1), imagesc ( im, [0, 255] ) ;
title( 'Input image' );
axis image off;
subplot(1,3,2), imagesc ( nimg, [0, 255] ) ; 
title( sprintf('Noisy image; PSNR = %.2f dB)', ...
    psnr1)) ;
axis image off;

subplot(1,3,3), imagesc ( imrec, [0, 255] ) ; 
title( sprintf('Shearlets; ,PSNR = %.2f dB)', ...
    psnr)) ;
colormap(gray);
axis image off;

%  Copyright (c) 2010. Wang-Q Lim, University of Osnabrueck
%
%  Part of ShearLab Version 1.0
%  Built Sun, 07/04/2010
%  This is Copyrighted Material
%  For Copying permissions see COPYRIGHT.m
