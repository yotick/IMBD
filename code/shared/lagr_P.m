function [IH3_new, H] = lagr_P(P,I)

global  ratio file_path_rgb256;
global count time curr_d gt256;
global sensor sate num

[H,sig,cor_old, P_L_ori] = get_gau_H_RS(P, I);
% [H2, I_PAN_LP] = get_H_MTF2(P,sensor,ratio);
% cor2 = corr2(I,I_PAN_LP);
% 
% if cor_old > cor2
%     H = H1;
% else
%     H = H2;
% end
% H = get_H_MTF(P,sensor,ratio); 

 [m,n] = size(P);
 
   switch sate
        case 'ik'
            u_crf = 15;   %% 越小越模糊,orig is 2
            u_flt = 0.1;  %% 越小越模糊
            gama_lagr = 0.02; %% 越大越模糊
%             gama_lagr = 0;
            alpha = 0.95;
            sigma = 17;  % wv2  26, ik 17
%             H = get_H_MTF(P,sensor,ratio);    %% 转换为FFT频率域可行 in IKONO is OK,
        case 'pl'
            u_crf = 12;
            u_flt = 0.01;
            gama_lagr = 0.01;
            alpha = 0.9;  
        case 'wv2'
            %            u = get_u(P,H,I);
            u_crf = 2;
            u_flt = 0.1;
            gama_lagr = 0.003;
            alpha = 1.5;      
            sigma = 20;  % wv2  26, ik 17
%             H = lpfilter('gaussian',PQ(1),PQ(2),sigma);      % in WV is OK,not in iK
    % *************original      
%             u_crf = 5;
%             u_flt = 0.1;
%             gama_lagr = 0.01;
%             alpha = 1.5;      
        case 'wv3'
            u_crf = 26;         % lambda in paper 
            gama_lagr = 0.05;      % bata in paper
              
%             u_crf = 23;  
%             gama_lagr = 0.6; 
            
            u_flt = 0.1;          
            
            alpha = 1.4;    % original 1.3
            sigma = 20;  % wv2  26, ik 17
%             H = lpfilter('gaussian',PQ(1),PQ(2),sigma);      % in WV is OK,not in iK
            % *******original
%              u_crf = 5;
%             u_flt = 0.1;
%             gama_lagr = 0.001;
%             alpha = 1.3;
        case 'wv3-8'
            u_crf = 26;         % lambda in paper 
            gama_lagr = 0.05;      % bata in paper
              
%             u_crf = 23;  
%             gama_lagr = 0.6; 
            
            u_flt = 0.1;          
            
            alpha = 1.4;    % original 1.3
            sigma = 20;  % wv2  26, ik 17
        case 'qb'
            u_crf = 3;
            u_flt = 0.01;
            gama_lagr = 0.01;
            alpha = 1;
        case 'geo'
%             u_crf = 10;
%             u_flt = 0.1;
%             gama_lagr = 0.0001;
            alpha = 1.2;

            u_crf = 50;
            u_flt = 0.1;
            gama_lagr = 0.05;
%             alpha = 1/corr2(P,I);
   end
   
   %% start
    lap = fspecial('laplacian',0);
%     lap = fspecial('prewitt');
    lap_f = freqz2(lap,size(P)); % laplase matrix
    lap_f = fftshift(lap_f);

    %% initial
    u2_flt = 0;         
    sig = 0;        
%     not in WV2 WV3
    %% CRFs model
    eps = 2*10^-3;
    iter = 0;
    lagr_m = ones(m);                % lagrange factor
    u_aug = 1;             % augment lagrange parameter   
    rho = 1.05;
    X = 0;
    IH3_old = I;
    IH3_new = P;
    while (norm(IH3_new-IH3_old)/norm(IH3_old)>eps)
        IH3_old = IH3_new;
%         iter = iter + 1
        A = H.*fft2(I) + u_crf*lap_f.*lap_f.* fft2(P)+lap_f.*fft2(lagr_m)+u_aug*lap_f.*fft2(X);
        B = H.*H + u_crf*lap_f.*lap_f + u_aug*lap_f.*lap_f;        
        C = A./B;
        IH3_new = real(ifft2(C));
%         H = filter_est(IH3_new,I,u2_flt,u_flt);
        X = shrink(real(ifft2(lap_f.*C))-1/u_aug*lagr_m, gama_lagr/u_aug);
        lagr_m = lagr_m +u_aug*(X - real(ifft2(lap_f.*C)));
        u_aug = rho*u_aug;
    end