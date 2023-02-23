function [H,sig,cor_old, P_L] = get_gau_H_RS(P, I)
global sate;

PQ = size(P);
cor_old = 0.5;
switch sate
    case 'ik'
        if PQ(1) == 64
            for sigma = 4:1:50
                H = lpfilter('gaussian',PQ(1),PQ(2),sigma); % PQ=[512 512]
                P_L = ifft2(fft2(P).*H);
                %     imshow(P_L);
                %     figure, imshow(I);
                cor_new = corr2(P_L, I);
                if(cor_new > cor_old)
                    cor_old = cor_new;
                else
                    break;
                end
            end
            sig = sigma;
        else
            for sigma = 12:2:50
                H = lpfilter('gaussian',PQ(1),PQ(2),sigma); % PQ=[512 512]
                P_L = ifft2(fft2(P).*H);
                %     imshow(P_L);
                %     figure, imshow(I);
                cor_new = corr2(P_L, I);
                if(cor_new > cor_old)
                    cor_old = cor_new;
                else
                    break;
                end
            end
            sig = sigma-2;
        end
    case 'pl'
        if PQ(1) == 64
            for sigma = 4:1:50
                H = lpfilter('gaussian',PQ(1),PQ(2),sigma); % PQ=[512 512]
                P_L = ifft2(fft2(P).*H);
                %     imshow(P_L);
                %     figure, imshow(I);
                cor_new = corr2(P_L, I);
                if(cor_new > cor_old)
                    cor_old = cor_new;
                else
                    break;
                end
            end
            sig = sigma;
        else
            for sigma = 12:2:50
                H = lpfilter('gaussian',PQ(1),PQ(2),sigma); % PQ=[512 512]
                P_L = ifft2(fft2(P).*H);
                %     imshow(P_L);
                %     figure, imshow(I);
                cor_new = corr2(P_L, I);
                if(cor_new > cor_old)
                    cor_old = cor_new;
                else
                    break;
                end
            end
%             sig = sigma-4;
        end
    case 'wv2'
        for sigma = 22:2:50
            H = lpfilter('gaussian',PQ(1),PQ(2),sigma); % PQ=[512 512]
            P_L = ifft2(fft2(P).*H);
            %     imshow(P_L);
            %     figure, imshow(I);
            cor_new = corr2(P_L, I);
            if(cor_new > cor_old)
                cor_old = cor_new;
            else
                break;
            end
        end
    case {'wv3','wv3-8'}
        if PQ(1) <= 64
            for sigma = 4:1:50
                H = lpfilter('gaussian',PQ(1),PQ(2),sigma); % PQ=[512 512]
                P_L = ifft2(fft2(P).*H);
                %     imshow(P_L);
                %     figure, imshow(I);
                cor_new = corr2(P_L, I);
                if(cor_new > cor_old)
                    cor_old = cor_new;
                else
%                     sigma = sigma +8;
                    break;
                end
            end
            %         sig = sigma;
        else
            for sigma = 15:2:50
                H = lpfilter('gaussian',PQ(1),PQ(2),sigma); % PQ=[512 512]
                P_L = ifft2(fft2(P).*H);
                %     imshow(P_L);
                %     figure, imshow(I);
                cor_new = corr2(P_L, I);
                if(cor_new > cor_old)
                    cor_old = cor_new;
                else
%                     sigma = sigma+6;
                    break;
                end
            end          
        end
       sigma = sigma+6;
    case 'qb'
        for sigma = 20:2:50
            H = lpfilter('gaussian',PQ(1),PQ(2),sigma); % PQ=[512 512]
            P_L = ifft2(fft2(P).*H);
            %     imshow(P_L);
            %     figure, imshow(I);
            cor_new = corr2(P_L, I);
            if(cor_new > cor_old)
                cor_old = cor_new;
            else
                break;
            end
        end
    case 'geo'
        for sigma = 10:2:50
            H = lpfilter('gaussian',PQ(1),PQ(2),sigma); % PQ=[512 512]
            P_L = ifft2(fft2(P).*H);
            %     imshow(P_L);
            %     figure, imshow(I);
            cor_new = corr2(P_L, I);
            if(cor_new > cor_old)
                cor_old = cor_new;
            else
                break;
            end
        end
%         sigma = sigma+6;
end

if strcmp(sate, 'tg')
     sig = 6;     % for 14 band images
else
    sig = sigma  ;
end

 sig = sigma ;  
H = lpfilter('gaussian',PQ(1),PQ(2),sig);
end