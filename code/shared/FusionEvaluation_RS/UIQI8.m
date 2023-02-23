% function [U_R,U_G,U_B]=UIQI1(RGB1,RGB2)
function T=UIQI1(RGB1,RGB2)
% 通用图像质量指标

RGB1=double(RGB1);
RGB2=double(RGB2);

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

U_R=u(r,R);
U_G=u(g,G);
U_B=u(b,B);
U_N=u(b,N);
U_R1=u(r1,R1);
U_G1=u(g1,G1);
U_B1=u(b1,B1);
U_N1=u(b1,N1);

% fprintf('\n   R的UIQI值为:%.4f\n   G的UIQI值为:%.4f\n   B的UIQI值为:%.4f\n   平均值为：%.4f\n',...
%     U_R, U_G, U_B, (U_R+U_G+U_B)/3);
T=(U_R+U_G+U_B+U_N+U_R1+U_G1+U_B1+U_N1)/8;
end


function g=u(A,B)
    [m,n]=size(A);
    m1=mean2(A);
    m2=mean2(B);
    s1=std2(A);
    s2=std2(B);
    c=sum(sum(abs((A-m1).*(B-m2))))/m/n;
    g=4*c*m1*m2/(s1^2+s2^2)/(m1^2+m2^2);
    
end




