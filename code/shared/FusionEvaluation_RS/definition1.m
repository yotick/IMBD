% function [D_R,D_G,D_B]=definition1(RGB)
function D=definition1(RGB)
% ��һ����ɫͼ���ͨ����������
% ����ͼ��ImΪ��ͨ���Ĳ�ɫͼ��[]
% ֵԽ��˵��ͼ��������Խ��

[M,N,~]=size(RGB);
RGB=double(RGB);
g_R=0;             % r����������
g_G=0;             % g����������
g_B=0;             % b����������

r=RGB(:,:,1);
g=RGB(:,:,2);
b=RGB(:,:,3);

 for ii=1:M-1
    for jj=1:N-1
        g_R=g_R+sqrt((((r(ii+1,jj)-r(ii,jj))^2+(r(ii,jj+1)-r(ii,jj))^2))/2);
        g_G=g_G+sqrt((((g(ii+1,jj)-g(ii,jj))^2+(g(ii,jj+1)-g(ii,jj))^2))/2);
        g_B=g_B+sqrt((((b(ii+1,jj)-b(ii,jj))^2+(b(ii,jj+1)-b(ii,jj))^2))/2);

    end
 end
D_R=g_R/(M-1)/(N-1);
D_G=g_G/(M-1)/(N-1);
D_B=g_B/(M-1)/(N-1);
D = (D_R+D_G+D_B)/3;
%  fprintf('\n   R��������Ϊ:%.4f\n   G��������Ϊ:%.4f\n   B��������Ϊ:%.4f\n   ƽ��ֵΪ��%.4f\n',...
%      D_R, D_G, D_B, (D_R+D_G+D_B)/3);

%  fprintf('\n   ƽ��������Ϊ��%.4f\n', (D_R+D_G+D_B)/3); 