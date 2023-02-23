function [A,PL, level,co] = comp_gausFilter(new_m, ori_m, comp_I)
% A is detail, PL is lew resolution version of P
[m,n] = size(comp_I);
level = 1;

sigma = 2;
gausFilter = fspecial('gaussian',[5 5],sigma);

L = zeros([m,n, 20]);
c = zeros([1, size(L,3)]);

L(:,:,1) = ori_m;
c(1) = corr2(L(:,:,1), comp_I);
% L(:,:,2) = imfilter(L(:,:,1),gausFilter,'replicate');
% c(2) = corr2(L(:,:,2), comp_I);
for i = 2 : size(L,3)
    L(:,:,i) = imfilter(L(:,:,i-1),gausFilter,'replicate');
    c(i) = corr2(L(:,:,i), comp_I);
    if(c(i)<= c(i-1))        
        level = i;
        break;
    end    
end
co = c(i-1);
L2 = zeros([m,n, level]);
L2(:,:,1) = imfilter(new_m,gausFilter,'replicate');
if level ==1     
else
    for i = 2: level
        L2(:,:,i) = imfilter(L2(:,:,i-1),gausFilter,'replicate');
    end
end

PL = L2(:,:,level);
% new_m=(new_m-mean(new_m(:)))*std2(ori_m)/std(new_m(:)) + mean2(ori_m);   % histogram matching
if(m > 256)
    A = new_m - L2(:,:,level-1);
else
    A = new_m - L2(:,:,level);
end