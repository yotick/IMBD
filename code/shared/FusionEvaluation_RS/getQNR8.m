function [D1,D2,QNR]=getQNR8(MsImg,PanImg,FusedImg)
% function QNR=getQNR(MsImg,PanImg,FusedImg)

FusedImg=double(FusedImg);
MsImg=double(MsImg);
PanImg=double(PanImg);

C1=FusedImg(:,:,1);
B1=FusedImg(:,:,2);
G1=FusedImg(:,:,3);
Y1=FusedImg(:,:,4);
R1=FusedImg(:,:,5);
RE1=FusedImg(:,:,6);
N11=FusedImg(:,:,7);
N12=FusedImg(:,:,8);

C2=FusedImg(:,:,1);
B2=FusedImg(:,:,2);
G2=FusedImg(:,:,3);
Y2=FusedImg(:,:,4);
R2=FusedImg(:,:,5);
RE2=FusedImg(:,:,6);
N21=FusedImg(:,:,7);
N22=FusedImg(:,:,8);

% 光谱失真程度
Q1=u(C1,B1);
Q2=u(C1,G1);
Q3=u(C1,Y1);
Q4=u(C1,R1);
Q5=u(C1,RE1);
Q6=u(C1,N11);
Q7=u(C1,N12);
Q8=u(B1,G1);
Q9=u(B1,Y1);
Q10=u(B1,R1);
Q11=u(B1,RE1);
Q12=u(B1,N11);
Q13=u(B1,N12);
Q14=u(G1,Y1);
Q15=u(G1,R1);
Q16=u(G1,RE1);
Q17=u(G1,N11);
Q18=u(G1,N12);
Q19=u(Y1,R1);
Q20=u(Y1,RE1);
Q21=u(Y1,N11);
Q22=u(Y1,N12);
Q23=u(R1,RE1);
Q24=u(R1,N11);
Q25=u(R1,N12);
Q26=u(RE1,N11);
Q27=u(RE1,N12);
Q28=u(N11,N12);

Q21=u(C2,B2);
Q22=u(C2,G2);
Q23=u(C2,Y2);
Q24=u(C2,R2);
Q25=u(C2,RE2);
Q26=u(C2,N21);
Q27=u(C2,N22);
Q28=u(B2,G2);
Q29=u(B2,Y2);
Q210=u(B2,R2);
Q211=u(B2,RE2);
Q212=u(B2,N21);
Q213=u(B2,N22);
Q214=u(G2,Y2);
Q215=u(G2,R2);
Q216=u(G2,RE2);
Q217=u(G2,N21);
Q218=u(G2,N22);
Q219=u(Y2,R2);
Q220=u(Y2,RE2);
Q221=u(Y2,N21);
Q222=u(Y2,N22);
Q223=u(R2,RE2);
Q224=u(R2,N21);
Q225=u(R2,N22);
Q226=u(RE2,N21);
Q227=u(RE2,N22);
Q228=u(N21,N22);

A1=2*(abs(Q1-Q21)^2)+2*(abs(Q2-Q22)^2)+2*(abs(Q3-Q23)^2)+2*(abs(Q4-Q24)^2)+2*(abs(Q5-Q25)^2)+2*(abs(Q6-Q26)^2)+2*(abs(Q7-Q27)^2)+2*(abs(Q8-Q28)^2)+2*(abs(Q9-Q29)^2);
A2=2*(abs(Q10-Q210)^2)+2*(abs(Q11-Q211)^2)+2*(abs(Q12-Q212)^2)+2*(abs(Q13-Q213)^2)+2*(abs(Q14-Q214)^2)+2*(abs(Q15-Q215)^2)+2*(abs(Q16-Q216)^2)+2*(abs(Q17-Q217)^2)+2*(abs(Q18-Q218)^2);
A3=2*(abs(Q19-Q219)^2)+2*(abs(Q20-Q220)^2)+2*(abs(Q21-Q221)^2)+2*(abs(Q22-Q222)^2)+2*(abs(Q23-Q223)^2)+2*(abs(Q24-Q224)^2)+2*(abs(Q25-Q225)^2)+2*(abs(Q26-Q226)^2)+2*(abs(Q27-Q227)^2);
A4=2*(abs(Q28-Q228)^2);
D1=sqrt((A1+A2+A3+A4)/58);

% 空间失真程度
Q31=u(C1,PanImg);
Q32=u(B1,PanImg);
Q33=u(G1,PanImg);
Q34=u(Y1,PanImg);
Q35=u(R1,PanImg);
Q36=u(RE1,PanImg);
Q37=u(N11,PanImg);
Q38=u(N12,PanImg);

Q321=u(C2,PanImg);
Q322=u(B2,PanImg);
Q323=u(G2,PanImg);
Q324=u(Y2,PanImg);
Q325=u(R2,PanImg);
Q326=u(RE2,PanImg);
Q327=u(N21,PanImg);
Q328=u(N22,PanImg);

D2=sqrt((abs(Q31-Q321)^2+abs(Q32-Q321)^2+abs(Q33-Q323)^2+abs(Q34-Q324)^2+abs(Q35-Q325)^2+abs(Q36-Q326)^2+abs(Q37-Q327)^2+abs(Q38-Q328)^2)/8);

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