% function [CR,CG,CB]=CC(RGB1,RGB2)
function C=CC4(RGB1,RGB2)
% 计算融合图像和源图像各通道的相关系数

RGB1=double(RGB1);
RGB2=double(RGB2);

% [m,n,k] = size(RGB1); 

r=RGB1(:,:,1);
g=RGB1(:,:,2);
b=RGB1(:,:,3);
n=RGB1(:,:,4);
r1=RGB1(:,:,5);
g1=RGB1(:,:,6);
b1=RGB1(:,:,7);
n1=RGB1(:,:,8);

R=RGB2(:,:,1);
G=RGB2(:,:,2);
B=RGB2(:,:,3);
N=RGB2(:,:,4);
R1=RGB2(:,:,5);
G1=RGB2(:,:,6);
B1=RGB2(:,:,7);
N1=RGB2(:,:,8);

mean_r = mean2(r);
mean_g = mean2(g);
mean_b = mean2(b);
mean_n = mean2(n);
mean_r1 = mean2(r1);
mean_g1 = mean2(g1);
mean_b1 = mean2(b1);
mean_n1 = mean2(n1);

mean_R = mean2(R);
mean_G = mean2(G);
mean_B = mean2(B);
mean_N = mean2(N);
mean_R1 = mean2(R1);
mean_G1 = mean2(G1);
mean_B1 = mean2(B1);
mean_N1 = mean2(N);

CR=sum(sum((r-mean_r).*(R-mean_R)))/sqrt(sum(sum((r-mean_r).^2))*sum(sum((R-mean_R).^2)));
CG=sum(sum((g-mean_g).*(G-mean_G)))/sqrt(sum(sum((g-mean_g).^2))*sum(sum((G-mean_G).^2)));
CB=sum(sum((b-mean_b).*(B-mean_B)))/sqrt(sum(sum((b-mean_b).^2))*sum(sum((B-mean_B).^2)));
CN=sum(sum((n-mean_n).*(N-mean_N)))/sqrt(sum(sum((n-mean_n).^2))*sum(sum((N-mean_N).^2)));
CR1=sum(sum((r1-mean_r1).*(R1-mean_R1)))/sqrt(sum(sum((r1-mean_r1).^2))*sum(sum((R1-mean_R1).^2)));
CG1=sum(sum((g1-mean_g1).*(G1-mean_G1)))/sqrt(sum(sum((g1-mean_g1).^2))*sum(sum((G1-mean_G1).^2)));
CB1=sum(sum((b1-mean_b1).*(B1-mean_B)))/sqrt(sum(sum((b1-mean_b1).^2))*sum(sum((B1-mean_B1).^2)));
CN1=sum(sum((n1-mean_n1).*(N1-mean_N1)))/sqrt(sum(sum((n1-mean_n1).^2))*sum(sum((N1-mean_N1).^2)));

C=(CR+CG+CB+CN+CR1+CG1+CB1+CN1)/8;

% fprintf('\n   R的相关系数为:%.4f\n   G的相关系数为:%.4f\n   B的相关系数为:%.4f\n   平均值为：%.4f\n',...
%     CR, CG, CB, (CR+CG+CB)/3);

% fprintf('\n   平均相关系数为：%.4f\n', C);

% =========================================================================
% ==================== 另一种相关系数CC的计算方法 ===========================
% q3=0;q4=0;p_r=0;
% for i=1:mf 
%     for j=1:nf 
%        if(r(i,j) ~= 0 && R(i,j) ~= 0)                         
%        q3=q3+(r(i,j)-mean_r)*(R(i,j)-mean_R);
%        q4=q4+sqrt(((r(i,j)-mean_r)^2)*((R(i,j)-mean_R)^2));   
%        end
%     end 
% end 
% p_r=q3/q4;
% 
% q11=0;q12=0;p_g=0;
% for i=1:mf 
%     for j=1:nf 
%        if(g(i,j) ~= 0 && G(i,j) ~= 0)                         
%        q11=q11+(g(i,j)-mean_g)*(G(i,j)-mean_G);
%        q12=q12+sqrt(((g(i,j)-mean_g)^2)*((G(i,j)-mean_G)^2));
%        end
%     end 
% end 
% p_g=q11/q12;
% 
% q13=0;q14=0;p_b=0;
% for i=1:mf 
%     for j=1:nf 
%        if(b(i,j) ~= 0 && B(i,j) ~= 0)
%        q13=q13+(b(i,j)-mean_b)*(B(i,j)-mean_B);
%        q14=q14+sqrt(((b(i,j)-mean_b)^2)*((B(i,j)-mean_B)^2));
%        end
%     end 
% end 
% p_b=q13/q14;
% 
% fprintf('\n   R的相关系数为:%.4f\n   G的相关系数为:%.4f\n   B的相关系数为:%.4f\n   平均值为：%.4f\n\n',...
%     p_r, p_g, p_b, (p_r+p_g+p_b)/3);

end