function [angle]= SAM(MS,F)
MS=double(MS);
F=double(F);
[m,n,d]=size(F);

for i=1:d
    A(:,:,i)= MS(:,:,i).*F(:,:,i);
    M(:,:,i)= MS(:,:,i).^2;
    F(:,:,i)= F(:,:,i).^2;
end

Asum=sum(A, 3);
Msum=(sum(M, 3)).^(1/2);
Fsum= (sum(F,3)).^(1/2);

for i=1:m
    for j=1:n
    U(i,j)= Asum(i,j)/(Msum(i,j)*Fsum(i,j));   
    end
end
U=min(U,1);

angle= (1/(m*n))*(sum(sum(acosd(U))));
