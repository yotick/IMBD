function haze_rate = get_haze_rate(I_MS, alpha1)
vCorr = zeros(1, size(I_MS,3));
for ii = 1 : size(I_MS,3)
    b = I_MS(:,:,ii);
    vCorr(ii) = min(b(:));
end
alpha(1,1,:) = alpha1;
v3Corr = zeros(1,1,size(I_MS,3));
v3Corr(1,1,:) = vCorr;
LCorr = repmat(v3Corr, [size(I_MS,1) size(I_MS,2)]);

I = sum((I_MS - LCorr) .* repmat(alpha,[size(I_MS,1) size(I_MS,2) 1]),3); 
haze_rate = (I_MS - LCorr) ./(repmat(I,[1 1 size(I_MS,3)]) + eps);
end