function f=MI(FusedImg,MsImg,PanImg)

% 求遥感图像融合中融合图像各通道与源多光谱图像各通道和全色图像的互信息

FusedImg=double(FusedImg);
MsImg=double(MsImg);

R1=FusedImg(:,:,1);
G1=FusedImg(:,:,2);
B1=FusedImg(:,:,3);

R2=MsImg(:,:,1);
G2=MsImg(:,:,2);
B2=MsImg(:,:,3);

if numel(size(PanImg))>2
    PanImg=rgb2gray(PanImg);
end
PanImg=double(PanImg);

MI1=mutural_information(R1,R2,PanImg,256);
MI2=mutural_information(G1,G2,PanImg,256);
MI3=mutural_information(B1,B2,PanImg,256);

f=(MI1+MI2+MI3)/3;

% fprintf('\n   互信息MI为:%.4f\n ',f);
end



function mutural_informationR=mutural_information(grey_matrixA,grey_matrixB,grey_matrixF,grey_level)
% mutural_informationR=mutural_information(grey_matrixA,grey_matrixB,grey_matrixF,grey_level)
% compute mutural information of the image
% grey_matrixA , grey_matrixB,grey_matrixF are grey values of imageA,imageB and fusion image
% grey_level is the grayscale degree of image
% please set grey_level=256

HA=entropy_fusion(grey_matrixA,grey_level);
HB=entropy_fusion(grey_matrixB,grey_level);
HF=entropy_fusion(grey_matrixF,grey_level);
HFA=Hab(grey_matrixF,grey_matrixA,grey_level);
HFB=Hab(grey_matrixF,grey_matrixB,grey_level);
MIFA=HA+HF-HFA;
MIFB=HB+HF-HFB;
mutural_informationR=MIFA+MIFB;
end
