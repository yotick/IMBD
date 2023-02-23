function Result=Evaluation5(imgMul,imgPan,F)

Result=zeros(1,7);
% Result=zeros(1,9);

Result(1,1)=CC8(imgMul,F);
Result(1,2)=UIQI8(imgMul,F);
Result(1,3)=RASE8(imgMul,F);
Result(1,4)=RMSE(imgMul,F);
Result(1,5)=SAM(imgMul,F);
Result(1,6)=ERGAS8(imgMul,F);
Result(1,7)=getQNR8(imgMul,imgPan,F);

disp('   ||  CC  ||  UIQI  ||  RASE  ||  RMSE  ||  SAM  ||  ERGAS  ||  QNR  ||')