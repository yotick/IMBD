function Result=Evaluation2(imgMul,imgPan,F)

% Result=zeros(1,10);
Result=zeros(1,3);
% Result(1,1)=MI(F,imgMul,imgPan);
% Result(1,2)=grad(F);
% Result(1,1)=std_avg(F);
% Result(1,1)=SF1(F);
% Result(1,4)=PSNR(F);
% Result(1,2)=IS(F);
[D1 D2 QNR]=getQNR(imgMul,imgPan,F);
Result(1,1)=D1;
Result(1,2)=D2;
Result(1,3)=QNR;

disp('   ||  D1  ||  D2  ||  QNR  ||  ')