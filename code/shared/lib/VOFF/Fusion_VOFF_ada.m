function [X_out]     =  Fusion_VOFF_ada(I_LRMS, I_PAN, X_net, opts )
%% Initiation
maxit = opts.maxit;
tol   = opts.tol;              
Nways = opts.Nways;
sz    = opts.sz;
alpha = opts.alpha;
eta_1 = opts.eta_1 ;
eta_2 = opts.eta_2 ;
ratio  = opts.ratio;
sensor = opts.sensor;
X      = SUB_sample(I_LRMS, ratio); % Initialize the X
P_3D = hist_mapping(I_LRMS, I_PAN, ratio, sz/ratio);
par  = FFT_kernel(ratio, sensor ,Nways);
tau  = adaptive_times(P_3D, opts);
W    = adaptive_weight(I_LRMS, I_PAN, X_net, par, ratio, sensor, tau);
% rng(1)
U     = zeros(Nways); 
V     = zeros(Nways); 
Thet_1= zeros(Nways); 
Thet_2= zeros(Nways); 
%%

X_k = X;
for it = 1:maxit
    % update X
    X    = X_subproblem(U, V, Thet_1, Thet_2, par, opts, tau);
    
    % update U
    U    = U_subproblem(I_LRMS, X, Thet_1, par, opts, tau);
    
    % update V
    V    = (eta_2*X+Thet_2+2*alpha*(W.^2).*X_net)  ./  (eta_2+2*alpha*(W.^2)); 
%      V    = wthresh(X-X_net+Thet_2/(eta_2+eps), 's', (alpha/(eta_2+eps))*W); 
% eps is used to prevent the denominator from being zero

    % update Thet_1
    Thet_1 = Thet_1+eta_1*(MTF_im(X, sensor, '', ratio)-U); % efficient 
%     Thet_1 = Thet_1+eta_1*(par.B(X)-U); % time-safe
    
    % update Thet_2
    Thet_2 = Thet_2+eta_2*(X-V);
    % update times
%     tau  =  updating_times(X, P_3D, opts, par);
    %%
    Rel_Err = norm(Unfold(X-X_k,Nways,3) ,'fro')/norm(Unfold(X_k,Nways,3),'fro');
    X_k = X;

    if Rel_Err < tol  
        break;
    end   
end

 X_out=X;
end

%#######################################