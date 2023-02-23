function G=grad(RGB)

RGB=double(RGB);
[mf,nf,kf] = size(RGB); 

r=RGB(:,:,1);
g=RGB(:,:,2);
b=RGB(:,:,3);

g_R=0;
g_G=0;
g_B=0;

 for i=1:mf-1
    for j=1:nf-1
        if(r(i,j) ~= 0 && r(i+1,j)~= 0 && r(i,j+1)~= 0)
           g_R=g_R+sqrt((((r(i+1,j)-r(i,j))^2 +(r(i,j+1)-r(i,j))^2 ))/2);
        end
        if(g(i,j) ~= 0 && g(i+1,j)~= 0 && g(i,j+1)~= 0)
           g_G=g_G+sqrt((((g(i+1,j)-g(i,j))^2+(g(i,j+1)-g(i,j))^2))/2);
        end
        if(b(i,j) ~= 0 && b(i+1,j)~= 0 && b(i,j+1)~= 0)
           g_B=g_B+sqrt((((b(i+1,j)-b(i,j))^2+(b(i,j+1)-b(i,j))^2))/2);
        end

    end
 end

G_R=g_R/(mf-1)/(nf-1);
G_G=g_G/(mf-1)/(nf-1);
G_B=g_B/(mf-1)/(nf-1);
G=(G_R+G_G+G_B)/3;
%  fprintf('\n\n   R的平均梯度为:%.4f\n   G的平均梯度为:%.4f\n   B的平均梯度为:%.4f\n   平均值为：%.4f\n',...
%      G_R, G_G, G_B, (G_R+G_G+G_B)/3);

end
