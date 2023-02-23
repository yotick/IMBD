function [sigma, H, cor_old, P_L] = get_gau_H_FS(P, I)
global sate;

PQ = size(P);
cor_old = 0.5;
switch sate
    case 'ik'
        for sigma = 65:2:150
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
     case 'qb'
        for sigma = 62:4:150
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
        for sigma = 104:2:150
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
    case 'pl'
        for sigma = 55:2:150
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
    case 'wv2'
        for sigma = 50:2:150
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
    case 'wv3'
        for sigma = 85:2:150
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
end
% sigma = sigma/cor_old;
sigma = sigma+2;  % the bigger, the blurrer 
H = lpfilter('gaussian',PQ(1),PQ(2),sigma);
end