 function d = shear_trans(x,pfilt,shear)
% This function generates the shearlet coefficients.
%
% Input :
%        x : input image
%        pfilt: name of filter for nuosubsampled LP (see atrousdec.m)
%        shear: cell array of directional shearing filters
%               (see shearing_filters_Myer.m).
%
% Output :
%        d : cell array of shearlet coefficients
%
% For instruction, see instruction.txt.
%
%
% Written by Wang-Q Lim on May 5, 2010. 
% Copyright 2010 by Wang-Q Lim. All Right Reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

level = length(shear);        
% number of scales


y = atrousdec(x,pfilt,level);
%decompose the input image into subbands of scales j = 1,...,level

d{1}=y{1};
% low frequency part

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% apply directional shearlet filters to decomposed images y{j} for each
% scale j

for j = 1:level
%     y{j+1} = fftshift(fft2((y{j+1})));
    y{j+1} = fft2((y{j+1}));
end

for j = 1:level
    num = size(shear{j},3);
    for k=1:num
        d{j+1}(:,:,k) = (ifft2(shear{j}(:,:,k).*y{j+1}));
    end
end


