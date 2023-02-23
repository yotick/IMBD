function haze = get_haze(I_PAN,I_MS,ratio)

vCorr = zeros(1, size(I_MS,3));
for ii = 1 : size(I_MS,3)
    b = I_MS(:,:,ii);
    vCorr(ii) = min(b(:));
end

v3Corr = zeros(1,1,size(I_MS,3));
v3Corr(1,1,:) = vCorr;
LCorr = repmat(v3Corr, [size(I_MS,1) size(I_MS,2)]);

imageHR = double(I_PAN);
I_MS = double(I_MS);

%%% Intensity
imageHR_LP = LPfilterGauss(imageHR,ratio);

h = estimation_alpha(I_MS,imageHR_LP,'global');
alpha(1,1,:) = h;
I = sum((I_MS - LCorr) .* repmat(alpha,[size(I_MS,1) size(I_MS,2) 1]),3); 

imageHR = (imageHR - mean2(LPfilterGauss(imageHR,ratio))).*(std2(I)./std2(LPfilterGauss(imageHR,ratio))) + mean2(I);  

haze = (I_MS - LCorr) ./(repmat(I,[1 1 size(I_MS,3)]) + eps);
end