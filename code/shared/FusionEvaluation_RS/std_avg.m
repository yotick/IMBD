function f=std_avg(RGB)

% 计算彩色图像各通道标准差平均值

RGB=double(RGB);
R=RGB(:,:,1);
G=RGB(:,:,2);
B=RGB(:,:,3);

f=(std2(R)+std2(G)+std2(B))/3;

% fprintf('\n   融合图像标准差std为:%.4f\n ',f);
end