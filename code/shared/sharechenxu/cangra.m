function cand=cangra(I)
% I = imread('QuickBird\01_pan.tif');  
I = double(I);  
[height,width] = size(I);  
J = I;    
conv = zeros(5,5);%��˹�����  
sigma = 1;%����  
sigma_2 = sigma * sigma;%��ʱ����  
sum = 0;  
for i = 1:5  
    for j = 1:5  
       conv(i,j) = exp((-(i - 3) * (i - 3) - (j - 3) * (j - 3)) / (2 * sigma_2)) / (2 * 3.14 * sigma_2);%��˹��ʽ  
       sum = sum + conv(i,j);  
     end  
end  
conv = conv./sum;%��׼��  
  
%��ͼ��ʵʩ��˹�˲�  
for i = 1:height  
    for j = 1:width  
        sum = 0;%��ʱ����  
         for k = 1:5  
             for m = 1:5  
                 if (i - 3 + k) > 0 && (i - 3 + k) <= height && (j - 3 + m) > 0 && (j - 3 + m) < width  
                     sum = sum + conv(k,m) * I(i - 3 + k,j - 3 + m);  
                 end  
             end  
         end  
         J(i,j) = sum;  
    end  
end  
%  figure,imshow(J,[])  
%   title('��˹�˲���Ľ��')  
 %���ݶ�  
 dx = zeros(height,width);%x�����ݶ�  
 dy = zeros(height,width);%y�����ݶ�  
 d = zeros(height,width);  
 for i = 1:height - 1  
     for j = 1:width - 1  
        dx(i,j) = J(i,j + 1) - J(i,j);  
        dy(i,j) = J(i + 1,j) - J(i,j);  
         d(i,j) = sqrt(dx(i,j) * dx(i,j) + dy(i,j) * dy(i,j));  
     end  
 end  
 cand=d;
%  figure,imshow(d,[])  
%  title('���ݶȺ�Ľ��')  
 
  