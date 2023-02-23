function H2 = get_H_MTF_P(I_PAN,sensor,ratio)
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
H2 = freqz2(h,size(I_PAN)); % laplase matrix
H2 = ifftshift(H2);
end