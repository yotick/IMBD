function [H, I_PAN_LP] = get_H_MTF2(I_PAN,sensor,ratio)
switch sensor
    case 'QB' 
        GNyq = 0.15; 
    case 'IKONOS'
        GNyq = 0.17;
    case 'GeoEye1'
        GNyq = 0.16;
    case 'WV2'
        GNyq = 0.11;
     case 'WV3'
        GNyq = 0.11;    %% new add  
    case 'none'
        GNyq = 0.15;
end


N = 41;
fcut = 1/ratio;
 
alpha = sqrt((N*(fcut/2))^2/(-2*log(GNyq)));
H = fspecial('gaussian', N, alpha);
Hd = H./max(H(:));
h = fwind1(Hd,kaiser(N));
H = freqz2(h,size(I_PAN)); % laplase matrix
H = ifftshift(H);
I_PAN_LP = imfilter(I_PAN,real(h),'replicate');
end