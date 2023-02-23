function f=SDI(FusedImg,MsImg)

[H1,S1,I1]=rgb2hsi(FusedImg);
[H2,S2,I2]=rgb2hsi(MsImg);

[m,n]=size(S1);

S=0;
for i=1:m
    for j=1:n
        if S2(i,j)~=0
            S=S+abs(S2(i,j)-S1(i,j))/S2(i,j);
        end
    end
end
f=S/(m*n);

end

function [H,S,I] = rgb2hsi(rgb)
rgb = im2double(rgb);
r = rgb(:, :, 1);
g = rgb(:, :, 2);
b = rgb(:, :, 3);

% 执行转换方程
num = 0.5*((r - g) + (r - b));
den = sqrt((r - g).^2 + (r - b).*(g - b));
theta = acos(num./(den + eps)); %防止除数为0

H = theta;
H(b > g) = 2*pi - H(b > g);
H = H/(2*pi);

num = min(min(r, g), b);
den = r + g + b;
den(den == 0) = eps; %防止除数为0
S = 1 - 3.* num./den;

H(S == 0) = 0;

I = (r + g + b)/3;

end