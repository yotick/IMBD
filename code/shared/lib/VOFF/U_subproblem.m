function U    = U_subproblem(I_LRMS, X, Thet_1, par, opts, tau)
eta_1    =  opts.eta_1;
sz       =  opts.sz;
lambda   =  opts.lambda;
ratio       =  opts.ratio;
Nways    =  opts.Nways;
% for tt = 1:Nways(3)
%     PAN_low(:,:,tt)= MTF_PAN(P_3D(:,:,tt), sensor, sf);
% end
temp_UP  =  par.ST(I_LRMS)+2*lambda*(tau.*X)+eta_1*par.B(X)+Thet_1;
% st = par.ST(I_LRMS);

SST      =  zeros(sz);
s0       =  3;
SST(s0:ratio:end,s0:ratio:end) = ones(sz/ratio);

temp_DOWN=  SST+eta_1;
temp_DOWN=  repmat(temp_DOWN, [1 1 Nways(3)])+2*lambda*tau.*tau;

U        = temp_UP./temp_DOWN;
end