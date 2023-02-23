function value = cov_lu(M,P)  

% 计算两副图像间的协方差

M=double(M);
P=double(P);
% PL=double(PL);

mean_M = mean2(M);
mean_P = mean2(P);
% mean_PL = mean2(PL);

% value = sum(sum((M-mean_M).*(P-mean_P)))/sum(sum((PL-mean_PL).*(P-mean_P)));
value = sum(sum((M-mean_M).*(P-mean_P)));
% CG=sum(sum((g-mean_g).*(R-mean_R)))/sqrt(sum(sum((g-mean_g).^2))*sum(sum((R-mean_R).^2)));
% CB=sum(sum((b-mean_b).*(R-mean_R)))/sqrt(sum(sum((b-mean_b).^2))*sum(sum((R-mean_R).^2))); 
end