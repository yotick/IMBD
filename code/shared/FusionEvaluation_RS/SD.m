function f=SD(MsImg,FusedImg)

% ����ң��ͼ���ں����ں�ͼ���Դ�����ͼ�Ĺ���Ť����

A1=double(FusedImg(:,:,1));
A2=double(FusedImg(:,:,2));
A3=double(FusedImg(:,:,3));

B1=double(MsImg(:,:,1));
B2=double(MsImg(:,:,2));
B3=double(MsImg(:,:,3));

f=(Spectral_distortion(A1,B1)+Spectral_distortion(A2,B2)+Spectral_distortion(A3,B3))/3;

% fprintf('\n   ����Ť����SDΪ:%.4f\n ',f);
end

function D=Spectral_distortion(A,B)

[m,n]=size(A);
D=sum(sum(abs(A-B)))/(m*n);
end


