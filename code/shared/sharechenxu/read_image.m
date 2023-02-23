function [m, p, ori] = read_image(str)

if (strcmp(str,  'se'))    % sea
    m = imread('source_images\QuickBird2\07_rgb.tif');
    p = imread('source_images\QuickBird2\07_pan.tif');
    ori = imread('source_images\QuickBird2\07_rgb_ori.tif');
end

if (strcmp(str,  's'))    % stadium
    m = imread('source_images\WorldView-2\nanchang04_mul.tif');
    p = imread('source_images\WorldView-2\nanchang04_pan.tif');
    ori = imread('source_images\WorldView-2\nanchang04.tif');
end

if(strcmp(str,  'n')) % nanchang 
    m = imread('source_images\WorldView-2\nanchang01_mul.tif');
    p = imread('source_images\WorldView-2\nanchang01_pan.tif');
    ori = imread('source_images\WorldView-2\nanchang01.tif');
end

if(strcmp(str,  'y')) % yellow forest 
    m = imread('source_images\ikonos-2\ik04_rgb.tif');
    p = imread('source_images\ikonos-2\ik04_pan.tif');
    ori = imread('source_images\ikonos-2\ik04_rgb_ori.tif');
end

if(strcmp(str,  'yk')) % yellow forest 
    m = imread('source_images\ikonos-2\ik03_rgb.tif');
    p = imread('source_images\ikonos-2\ik03_pan.tif');
    ori = imread('source_images\ikonos-2\ik03_rgb1.tif');
end

if(strcmp(str,  'p')) %  real picture park 
    m = imread('source_images\ikonos-2\03_mul.tif');
    p = imread('source_images\ikonos-2\03_pan.tif');
    ori = imread('source_images\ikonos-2\03_mul.tif');
end

if(strcmp(str,  'b')) %  real picture beach 
    m = imread('source_images\3_Haibian\Mul_海边_2.tif');
    p = imread('source_images\3_Haibian\Pan_海边_2.tif');
    ori = imread('source_images\3_Haibian\Mul_海边_2.tif');
     p = rgb2gray(p);  
end

if(strcmp(str,  'c')) %  real picture city 
    m = imread('source_images\2_Chengshi\Mul_城区_2.tif');
    p = imread('source_images\2_Chengshi\Pan_城区_2.tif');
    ori = imread('source_images\2_Chengshi\Mul_城区_2.tif');
    p = rgb2gray(p);  
end

if(strcmp(str,  'st')) %  real picture street 
    m = imread('source_images\2_Chengshi\Mul_城区_4.tif');
    p = imread('source_images\2_Chengshi\Pan_城区_4.tif');
    ori = imread('source_images\2_Chengshi\Mul_城区_4.tif');
    p = rgb2gray(p);  
end

