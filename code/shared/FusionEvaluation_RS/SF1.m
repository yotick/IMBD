function f=SF1(RGB)

% 计算彩色图像各通道空间频率平均值

RGB=double(RGB);
R=RGB(:,:,1);
G=RGB(:,:,2);
B=RGB(:,:,3);

f=(space_frequency(R)+space_frequency(G)+space_frequency(B))/3;

% fprintf('\n   R的空间频率为:%.4f\n   G的空间频率为:%.4f\n   B的空间频率为:%.4f\n   平均值为：%.4f\n',...
%     space_frequency(R), space_frequency(G), space_frequency(B), (space_frequency(R)+space_frequency(G)+space_frequency(B))/3);
% fprintf('\n   融合图像空间频率SF为:%.4f\n ',f);
end



function SF=space_frequency(X)
X=double(X);
[n0,n1]=size(X);%%%%   X是一个方阵
X=double(X);                          %空间频率;
RF=0;
CF=0;

for fi=1:n0
    for fj=2:n1
        RF=RF+(X(fi,fj)-X(fi,fj-1)).^2;
    end
end

RF=RF/(n0*n1);

for fj=1:n1
    for fi=2:n0
        CF=CF+(X(fi,fj)-X(fi-1,fj)).^2;
    end
end

CF=CF/(n0*n1);%%%%可以思考，空间频率是不是只描述一个方阵

SF=sqrt(RF+CF);
end