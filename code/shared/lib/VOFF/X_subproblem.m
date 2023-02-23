function X_out = X_subproblem(U, V, Thet_1, Thet_2, par, opts, tau)
sz    = opts.sz;
Nways = opts.Nways;
eta_1 = opts.eta_1 ;
eta_2 = opts.eta_2 ;
lambda = opts.lambda;

X_out = zeros(Nways);
for sp=1:Nways(3)
    Temp = tau.*U;
    FFT_Up = 2*lambda*fft2(Temp(:,:,sp))+...
        eta_1*fft2(U(:,:,sp)).*par.fft_BT(:,:,sp)-fft2(Thet_1(:,:,sp)).*par.fft_BT(:,:,sp)...
        +eta_2*fft2(V(:,:,sp))-fft2(Thet_2(:,:,sp));
    
    FFT_Down = eta_1*par.fft_B(:,:,sp).*par.fft_BT(:,:,sp) + (2*lambda+eta_2);
    
    X_out(:,:,sp) =real(ifft2(FFT_Up./FFT_Down));
end
    X_out(X_out>1)=1;
    X_out(X_out<0)=0;
end 