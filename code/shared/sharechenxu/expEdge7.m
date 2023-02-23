function [F]= expEdge7(Pan, lamda,eps)
% [FX,FY] = gradient(Pan);
% u=((FX.*FX)+(FY.*FY)).^(1/2);
 scale_num = 5;
   u = cangra(Pan);
%a = max(max(abs(u)))
[m,n]=size(u); 
F= exp( -((lamda*(ones(m,n)))./((abs(u).*abs(u).*abs(u).*abs(u))+ eps)));