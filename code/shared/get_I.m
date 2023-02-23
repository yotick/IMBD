function [I,alpha] = get_I(sate,M, P)

switch sate
    case 'tg'
%                 alpha =impGradDes(M,P);
%         alpha = estimation_alpha(M,P,'global');
         alpha(1:size(M,3)) = 1/size(M,3);
        I = zeros(size(M, 1), size(M, 2));        
        for i = 1 : size(M,3)
            I = I + alpha(i) * M(:,:,i);
        end
    case 'ik'
        alpha(1:4) = 1/4;
%                 alpha =impGradDes(M,P);
%          alpha = estimation_alpha(M,P,'global');
        I=alpha(1)*M(:,:,1)+alpha(2)*M(:,:,2)+alpha(3)*M(:,:,3)+alpha(4)*M(:,:,4);
    case 'pl'
        %         alpha =impGradDes(M,P);
        alpha(1:4) = 1/4;
        I=alpha(1)*M(:,:,1)+alpha(2)*M(:,:,2)+alpha(3)*M(:,:,3)+alpha(4)*M(:,:,4);
    case 'wv3'
        alpha =impGradDes(M,P);
        %         alpha = estimation_alpha(M,P,'global');
        %         alpha(1:4) = 1/4;
        I=alpha(1)*M(:,:,1)+alpha(2)*M(:,:,2)+alpha(3)*M(:,:,3)+alpha(4)*M(:,:,4);
    case 'wv3-8'
        %         alpha =impGradDes(M,P);
        alpha = estimation_alpha(M,P,'global');
        %                 alpha(1:8) = 1/8;
        I= alpha(1)*M(:,:,1)+alpha(2)*M(:,:,2)+alpha(3)*M(:,:,3)+alpha(4)*M(:,:,4)+ ...
            alpha(5)*M(:,:,5)+alpha(6)*M(:,:,6)+alpha(7)*M(:,:,7)+alpha(8)*M(:,:,8);
    case 'wv2'
        alpha =impGradDes(M,P);
        %         alpha(1:4) = 1/4;
        I=alpha(1)*M(:,:,1)+alpha(2)*M(:,:,2)+alpha(3)*M(:,:,3)+alpha(4)*M(:,:,4);
    case 'qb'
        %         alpha(1:4) = 1/4;
        alpha =impGradDes(M,P);
        I=alpha(1)*M(:,:,1)+alpha(2)*M(:,:,2)+alpha(3)*M(:,:,3)+alpha(4)*M(:,:,4);
        co_PI = corr2(P,I);
        if co_PI < 0.85
            alpha =impGradDes(M,P);   % gradient desend  method to calculate coefficient alpha with min||P-sigmoid alpha*M ||
            I=alpha(1)*M(:,:,1)+alpha(2)*M(:,:,2)+alpha(3)*M(:,:,3)+alpha(4)*M(:,:,4);
        end
    case 'geo'
        alpha =impGradDes(M,P);   % gradient desend  method to calculate coefficient alpha with min||P-sigmoid alpha*M ||
        %         alpha(1:4) = 1/4;
        I=alpha(1)*M(:,:,1)+alpha(2)*M(:,:,2)+alpha(3)*M(:,:,3)+alpha(4)*M(:,:,4);
        
        %         I=alpha(1)*M(:,:,1)+alpha(2)*M(:,:,2)+alpha(3)*M(:,:,3)+alpha(4)*M(:,:,4);
end