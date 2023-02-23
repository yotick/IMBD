function [N]=ERGAS(MS,F)
MS=double(MS);
F=double(F);

[m,n,p]=size(F);
M1=F(:,:,1);
M2=F(:,:,2);
M3=F(:,:,3);

A1=reshape(M1,[m*n,1]);
A2=reshape(M2,[m*n,1]);
A3=reshape(M3,[m*n,1]);

C1=(sum(sum((MS(:,:,1)-F(:,:,1)).^2))/(m*n))^(1/2);
C2=(sum(sum((MS(:,:,2)-F(:,:,2)).^2))/(m*n))^(1/2);
C3=(sum(sum((MS(:,:,3)-F(:,:,3)).^2))/(m*n))^(1/2);

S1=(C1/mean(A1))^2;
S2=(C2/mean(A2))^2;
S3=(C3/mean(A3))^2;

if p==4
    M4=F(:,:,4);
    A4=reshape(M4,[m*n,1]);
    C4=(sum(sum((MS(:,:,4)-F(:,:,4)).^2))/(m*n))^(1/2);
    S4=(C4/mean(A4))^2;
    S=S1+S2+S3+S4;
    N=((S/4)^(1/2))*(25);
else if p==8
    M4=F(:,:,4);
    M5=F(:,:,5);
    M6=F(:,:,6);
    M7=F(:,:,7);
    M8=F(:,:,8);
    A4=reshape(M4,[m*n,1]);
    A5=reshape(M5,[m*n,1]);
    A6=reshape(M6,[m*n,1]);
    A7=reshape(M7,[m*n,1]);
    A8=reshape(M8,[m*n,1]);

    C4=(sum(sum((MS(:,:,4)-F(:,:,4)).^2))/(m*n))^(1/2);
    C5=(sum(sum((MS(:,:,5)-F(:,:,5)).^2))/(m*n))^(1/2);
    C6=(sum(sum((MS(:,:,6)-F(:,:,6)).^2))/(m*n))^(1/2);
    C7=(sum(sum((MS(:,:,7)-F(:,:,7)).^2))/(m*n))^(1/2);
    C8=(sum(sum((MS(:,:,8)-F(:,:,8)).^2))/(m*n))^(1/2);
    S4=(C4/mean(A4))^2;
    S5=(C5/mean(A5))^2;
    S6=(C6/mean(A6))^2;
    S7=(C7/mean(A7))^2;
    S8=(C8/mean(A8))^2;
            
    S=S1+S2+S3+S4+S5+S6+S7+S8;
    N=((S/8)^(1/2))*(25);  
    else
    S=S1+S2+S3;
    N=((S/3)^(1/2))*(25);
    end
end
