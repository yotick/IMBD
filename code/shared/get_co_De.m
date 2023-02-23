function beta = get_co_De(P, M_ori)

global sensor ratio sate;

ms_LP = MTF(M_ori,sensor,[],ratio);
ms_LP_d = imresize(ms_LP,1/ratio);
ms_up = imresize(ms_LP_d, ratio);
Dm = M_ori-ms_up;

P_d = imresize(P,1/ratio);
P_dl = MTF_PAN(P_d,sensor,ratio);
D_Pd = P_d - P_dl;

for i = 1:4
    %% degrade scale
    
    beta(i) = impGradDes(D_Pd, Dm(:,:,i) );  % 4*5
%     beta(i) = impGradDes(Dm(:,:,i), D_Pd); 
end
end
