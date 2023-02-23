function f = IS(RGB) 

% 计算彩色图像各通道信息熵平均值

RGB=double(RGB);
R=RGB(:,:,1);
G=RGB(:,:,2);
B=RGB(:,:,3);

f=(shannon(R)+shannon(G)+shannon(B))/3;

% fprintf('\n   融合图像信息熵IS为:%.4f\n ',f);
end


function S = shannon(img) 

I=img;
%I=double(I);
[C,R]=size(I);      %求图像的规格
Img_size=C*R;       %图像像素点的总个数
L=256;              %图像的灰度级
H_img=0;
nk=zeros(L,1);
for i=1:C
    for j=1:R
        Img_level=I(i,j)+1;                 %获取图像的灰度级           
        nk(Img_level)=nk(Img_level)+1;      %统计每个灰度级像素的点数
    end
end
for k=1:L
    Ps(k)=nk(k)/Img_size;                  %计算每一个灰度级像素点所占的概率
    if Ps(k)~=0;                           %去掉概率为0的像素点
    H_img=-Ps(k)*log2(Ps(k))+H_img;        %求熵值的公式
    S=H_img;
    end
end
end
