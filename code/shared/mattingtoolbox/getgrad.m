function g=getgrad(A)

[m,n]=size(A);
% A1=padarray(A,[1 1],'replicate');     % æÿ’Û±ﬂΩÁÃÓ≥‰
A1=padarray(A,[1 1]); 
gradA=cell(m,n);
 for i=1:m
    for j=1:n
        gradA{i,j}(1)=A1(i+2,j+1)-A1(i+1,j+1);
        gradA{i,j}(2)=A1(i+1,j+2)-A1(i+1,j+1);
    end
 end
 
 gradA1=padarray(gradA,[1 1],'replicate'); 
 E=zeros(m,n);

 for a=2:m+1
     for b=2:n+1
         B(1,:)=gradA1{a-1,b-1};
         B(2,:)=gradA1{a-1,b};
         B(3,:)=gradA1{a-1,b+1};
         B(4,:)=gradA1{a,b-1};
         B(5,:)=gradA1{a,b};
         B(6,:)=gradA1{a,b+1};
         B(7,:)=gradA1{a+1,b-1};
         B(8,:)=gradA1{a+1,b};
         B(9,:)=gradA1{a+1,b+1};
         [U,S,V]=svd(double(B));
         lmd1=S(1,1);lmd2=S(2,2);
         E(a-1,b-1)=lmd1+lmd2;
     end
 end
         g=E;
end
 
 