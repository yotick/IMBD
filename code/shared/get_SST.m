function [sst, st] = get_SST(I_LRMS, I_PAN)

global sensor;

[~,~,L]  = size(I_LRMS);
sz          = size(I_PAN);
Nways   = [sz, L];
opts = [];
opts.lambda = 0.0013;
opts.alpha    = 0.0;
opts.eta_1    = 0.04;
opts.eta_2    = 0.03;
opts.ratio     = 4;
opts.Nways  = Nways;
opts.sz     = sz;
opts.tol    = 2*1e-5;   
opts.maxit  = 200;
opts.sensor = sensor;

maxit = opts.maxit;
tol   = opts.tol;              
Nways = opts.Nways;
sz    = opts.sz;
alpha = opts.alpha;
eta_1 = opts.eta_1 ;
eta_2 = opts.eta_2 ;
ratio  = opts.ratio;
sensor = opts.sensor;

par  = FFT_kernel(ratio, sensor ,Nways);

SST      =  zeros(sz);
s0       =  3;
SST(s0:ratio:end,s0:ratio:end) = ones(sz/ratio);

sst = SST;
st = par.ST(I_LRMS);
end



