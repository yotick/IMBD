function [D1,D2,QNR]=getQNR(MsImg,PanImg,FusedImg)
% function QNR=getQNR(MsImg,PanImg,FusedImg)

FusedImg=double(FusedImg);
MsImg=double(MsImg);
PanImg=double(PanImg);

R1=FusedImg(:,:,1);
G1=FusedImg(:,:,2);
B1=FusedImg(:,:,3);

R2=MsImg(:,:,1);
G2=MsImg(:,:,2);
B2=MsImg(:,:,3);


% 光谱失真程度
Q1=u(R1,G1);
Q2=u(R1,B1);
Q3=u(B1,G1);

Q4=u(R2,G2);
Q5=u(R2,B2);
Q6=u(B2,G2);

D1=sqrt((2*(abs(Q1-Q4)^2)+2*(abs(Q2-Q5)^2)+2*(abs(Q3-Q6)^2))/6);

% 空间失真程度
Q11=u(R1,PanImg);
Q12=u(G1,PanImg);
Q13=u(B1,PanImg);

Q14=u(R2,PanImg);
Q15=u(G2,PanImg);
Q16=u(B2,PanImg);
D2=sqrt((abs(Q11-Q14)^2+abs(Q12-Q15)^2+abs(Q13-Q16)^2)/3);

% 计算QNR
QNR=(1-D1)*(1-D2);

end

% 计算UIQI函数
function g=u(A,B)
    [m,n]=size(A);
    m1=mean2(A);
    m2=mean2(B);
    s1=std2(A);
    s2=std2(B);
    c=sum(sum(abs((A-m1).*(B-m2))))/m/n;
    g=4*c*m1*m2/(s1^2+s2^2)/(m1^2+m2^2);
    
end