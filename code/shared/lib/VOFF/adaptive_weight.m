function W    =  adaptive_weight(I_LRMS, ~, X_net, ~, sf, sensor, tau)
% Err=abs(Xhf-LMS);

Xhf_blur = MTF_im(X_net, sensor, '', sf);

Error_hr = abs(Xhf_blur-interp23tap(I_LRMS, sf)).*tau;

W=abs(sqrt(1-Error_hr));

end