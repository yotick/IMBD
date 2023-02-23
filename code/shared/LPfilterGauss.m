function I_PAN_LR = LPfilterGauss(I_PAN,ratio)

    GNyq = 0.3;
    N = 41;
    fcut = 1/ratio;

    alpha = sqrt((N*(fcut/2))^2/(-2*log(GNyq)));
    H = fspecial('gaussian', N, alpha);
    Hd = H./max(H(:));
    h = fwind1(Hd,kaiser(N));
    I_PAN_LR = imfilter(I_PAN,real(h),'replicate');

end