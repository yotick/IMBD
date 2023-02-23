function [CR,CG,CB]=CCF(RGB,RAY)

% 计算融合图像和源图像各通道的相关系数

RGB=double(RGB);
RAY=double(RAY);
r=RGB(:,:,1);
g=RGB(:,:,2);
b=RGB(:,:,3);
b=RGB(:,:,3);
R=RAY;

mean_r = mean2(r);
mean_g = mean2(g);
mean_b = mean2(b);
mean_R = mean2(R);

CR=sum(sum((r-mean_r).*(R-mean_R)))/sqrt(sum(sum((r-mean_r).^2))*sum(sum((R-mean_R).^2)));
CG=sum(sum((g-mean_g).*(R-mean_R)))/sqrt(sum(sum((g-mean_g).^2))*sum(sum((R-mean_R).^2)));
CB=sum(sum((b-mean_b).*(R-mean_R)))/sqrt(sum(sum((b-mean_b).^2))*sum(sum((R-mean_R).^2)));

 
end