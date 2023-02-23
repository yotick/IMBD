function Result=Evaluation4(imgMul,imgPan,F)

Result=zeros(1,7);
% Result=zeros(1,9);

Result(1,1)=CC4(imgMul,F);
Result(1,2)=UIQI(imgMul,F);
Result(1,3)=RASE(imgMul,F);
Result(1,4)=RMSE(im2double(imgMul),im2double(F));
Result(1,5)=SAM4(imgMul,F);
Result(1,6)=ERGAS(imgMul,F);
Result(1,7)=getQNR4(imgMul,imgPan,F);

disp('   ||  CC  ||  UIQI  ||  RASE  ||  RMSE  ||  SAM  ||  ERGAS  ||  QNR  ||');