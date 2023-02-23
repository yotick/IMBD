function [I2,h]  = get_I_haze(M, P,ratio)
%%% Intensity
vCorr = zeros(1, size(M,3));
for ii = 1 : size(M,3)
    b = M(:,:,ii);
    vCorr(ii) = min(b(:));
end

v3Corr = zeros(1,1,size(M,3));
v3Corr(1,1,:) = vCorr;
LCorr = repmat(v3Corr, [size(M,1) size(M,2)]);
imageHR_LP = LPfilterGauss(P,ratio);

h = estimation_alpha(M,imageHR_LP,'global');
alpha2(1,1,:) = h;
% I2 = sum((M - LCorr) .* repmat(alpha2,[size(M,1) size(M,2) 1]),3); 
I2 = sum((M ) .* repmat(alpha2,[size(M,1) size(M,2) 1]),3); 