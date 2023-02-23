function A = create_DS(m,n,s)
% produce the down-scaling matrix A
% [m,n] = size(HR); % the colume and row of HR image
As = (1/s^2).*ones(1,s);
BA = DiagonalCat(m/s,As);
CA = repmat(BA,1,s);
A = DiagonalCat(n/s,CA);

function [out] = DiagonalCat(s,A)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   produce block diagonal matrix
%   Copyright vvcumt(Liang Weiwei), DUT.  2010-09-27
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % A =  
% %      1     1
% % s =
% %      3
% % out =
% %      1     1     0     0     0     0
% %      0     0     1     1     0     0
% %      0     0     0     0     1     1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,n] = size(A);% A is basic block
out = zeros(s*m,s*n);
for i = 1:s
    out((i-1)*m+1:i*m , (i-1)*n+1:i*n) = A;
end