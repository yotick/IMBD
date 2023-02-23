function tau    =  adaptive_times(P_3D, opts)
ratio = opts.ratio; 
sensor = opts.sensor;
Nways  = opts.Nways;
PAN_low = zeros(Nways);

%% 
for band = 1:Nways(3)
    PAN_low(:,:,band)= MTF_PAN(P_3D(:,:,band), sensor, ratio);
end
tau = P_3D./PAN_low;
%%

end