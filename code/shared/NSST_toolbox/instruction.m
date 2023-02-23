
%%%%%%%%%%%%%%%%%%%%  Instruction for the shearlet transform and its inverse %%%%%%%%%%%%%%%%%%%%%%%% 


%(NOTE) One of routines in this pacakge needs to be complied through MEX - 'atrousc.c' (from contourlet toolbox). 
% I have included precomplied code for this for Windows XP. If your working
% platform is NOT Windows, please compile 'atrousc.c' by simply typing 
% 'mex atrous.c' on matlab command mode. 

%From now on, I assume that scale j = 0,1,...,L where j = 0 corresponds to low frequency and j = 1...L 
%correspond to coarse to fine scales.  Also, a parameter ndir = [n(1),..n(j)...,n(L)] determines 
%the number of shear parameters (number of directions) across scales j.
%For each scale j, shear parameters run k = -2^(n(j)-2)...2^(n(j)-2), which gives 2^(n(j)-1)+1 directions for each cone 
%(vertical and horizontal cones).---> Total number of directions is 2*(2^(n(j)-1)+1) = 2^(n(j))+2 for each scale j.  

shear=shearing_filters_Myer(m,ndir,N);
% generating shearing filters for each scale.
% shear : cell array of shearing (wedge shaped) filters where dshear{j}(:,:,k) is a shearing filter for scale 
% j and shear parameter k. 
% m : size of shearing filters across scales. 
% m = [m(1),...,m(j),...,m(L)] ---> size of shearing filter is m(j) by m(j) at scale j. 
% ndir : number of shearing filters across scales. 
% ndir = [n(1),...,n(j),...,n(L)] ---> 2^(n(j))+2 shearing filters  will be produced at scale j.
%
% (NOTE) To have better frequency localization, it is recommended that m(j)
% should be divisible by 2^(n(j)-1)+1 and m(j) <= N (size of the input image). 
% For examle, ndir = [3 3 4 4] ---> 
% m = [5*(any positive integer), 5*(any positive integer), 9*(any positive integer), 9*(any positive integer)] where
% all entries m(j) <= N.
%
% N : size of the input image (N by N).
%
% For example, 'shear=shearing_filters_Myer([70 70 9*17 9*17],[3 3 4 4],512)' will produce 
% 10 shearing filters (70 by 70) at scale j = 1 (coarse scale) ---> shear{1}(:,:,k) where k = 1,...,10.
% 10 shearing filters (70 by 70) at scale j = 2 ---> shear{2}(:,:,k) where k = 1,...,10.
% 18 shearing filters (153 by 153) at scale j = 3 ---> shear{3}(:,:,k) where k = 1,...,18.
% 18 shearing filters (153 by 153) at scale j = 4 (fine scale) ---> shear{4}(:,:,k) where k = 1,...,18.

E = com_norm(pfilt,size(img),shear);
% E : l^2 norm of shearlet for each scale j and shear parameter k ---> 
%     each entry of the output matrix E is given by E(j,k). 
% pfilt : name of LP filter ---> simply set 'pfilt = 'maxflat' (or '9-7').
% size(img) : size of the input image where 'img' is the input image. 
% shear : shearing filters obtained by 'shearing_filters_Myer'.

d=shear_trans(img,pfilt,shear); %forward shearlet transform.
% d : cell array of the shearlet coefficients.
% With N by N input image and shearing filters 'shear' obtained as above, we have 
% d{0} : low frequency part N by N 
% d{1} : 2^(n(1))+2 arrays (N by N) of the shearlet coefficients for shear parameters 
%        k = -2^(n(1)-1)...2^(n(1)-1) and scale j = 1 (coarse scale).
% ....
% d{L} :  2^(n(L))+2 arrays (N by N) of the shearlet coefficients for shear parameters 
%        k = -2^(n(L)-1)...2^(n(L)-1) and scale j = L (fine scale).
%
% Here, each entry of d is given by d{j}(n1,n2,k) ---> j : scale, k : shear parameter, 
% and n1&n2 : translation. 
% 
% img : input image (N by N).
% pfilt : name of LP filter ---> simply let pfilt = 'maxflat' or pfilt = '9-7'.
% shear : shearing filters obtained as above. 

c = thresh(d,lambda,2,E,sc,0); % threshold the shearlet coefficients d. 

% c : thresholded shearlet coeff (Hard Thresholding). 
% d : shearlet coeff 
% lambda & sc : thresholding parameters where lamabda can be any positive number and 
% sc = [sc(0),sc(1),...sc(j),...,sc(L)] with positive entry sc(j) for each scale j . 
% (NOTE) length of 'sc' should be L+1 where j = L is the finest scale and j = 0 corresonds to 
% low frequency.  
%
% This function performs Hard-Threshodling as follows :
% For each shearlet coefficient d{j}(n1,n2,k), 
% (case 1) set d{j}(n1,n2,k) = 0 if |d{j}(n1,n2,k)|/E(j,k) < sc(j)*lambda 
% (case 2) keep d{j}(n1,n2,k) if |d{j}(n1,n2,k)|/E(j,k) >= sc(j)*lambda 
% Here, E(j,k) is l^2 norm of shearlet for each scale j ans shear parameter k (obtained by 'com_norm'). 

x = inverse_shear(c,pfilt,shear); % inverse shearlet transform.

% x : reconstructed image.
% c : shearlet coeff. 
% pfilt : name of LP filter ---> simply set pfilt = 'maxflat' or '9-7'.
% shear : shearing filters obtained by 'shearing_filters_Myer'. 

%%%%%%%%%%%%%%%%%% simple image denoising with the shearlet transform %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% (See also deno_Barbara_shearlets.m and deno_Lena_shearlets.m) %%%%%%%%%%%%  

%Input data : 512 by 512 noisy image (gray scale 0-255) ---> nimg : 512 by 512 noisy image .   
%Noise type : Gaussian noise (standard deviation is 30). 

%First, compute shearing filters 

shear =shearing_filters_Myer([30 30 30 30],[2 2 3 3],512);
% This produces 6 shearing filters (30 by 30) at scale j = 1
%               6 shearing filters (30 by 30) at scale j = 2
%               10 shearing filters (30 by 30) at scale j = 3
%               10 shearing filters (30 by 30) at scale j = 4

% Compute l^2 norm of shearlets 
E = com_norm('maxflat',size(nimg),shear);

% NOTE) One could save precomputed 'shear' (cell array of shearing filters) and 'E' (l^2 norm of shearlets) 
%       for future use   

% With these pre-computed shearlet filters and l^2 of shearlets, compute the 
% shearlet transform and its inverse. 

d=shear_trans(nimg,'maxflat',shear);

% Hard_Thresholding 

c = thresh(d,30,2,E,[3 2.6 2.6 2.6 3.5],0);
% Here, 'sc' does not have to be [3 2.6 2.6 2.6 3.5] and one can choose any other possibility. 

% Image reconstruction with the thresholded coeff. 

x = inverse_shear(c,'maxflat',shear);
