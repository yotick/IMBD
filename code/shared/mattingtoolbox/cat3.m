function M=cat3(A,c)

[m,n]=size(A);
M=zeros(m,n,c);
for i=1:c
    M(:,:,i)=A;
end

end