function Result=Evaluation1(imgMul,imgPan,F)

% Result=zeros(1,7);
Result=zeros(1,8);
% Result=zeros(1,9);

Result(1,1)=CC(imgMul,F);
Result(1,2)=UIQI1(imgMul,F);
Result(1,3)=RASE(imgMul,F);
Result(1,4)=RMSE(imgMul,F);
Result(1,5)=SAM(imgMul,F);
Result(1,6)=ERGAS(imgMul,F);
Result(1,7)=getQNR(imgMul,imgPan,F);
% Result(1,8)=psnr(imgMul,F);
disp('   ||  CC  ||  UIQI  ||  RASE  ||  RMSE  ||  SAM  ||  ERGAS  ||  QNR  || PSNR ||')