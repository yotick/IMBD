function f=std_avg(RGB)

% �����ɫͼ���ͨ����׼��ƽ��ֵ

RGB=double(RGB);
R=RGB(:,:,1);
G=RGB(:,:,2);
B=RGB(:,:,3);

f=(std2(R)+std2(G)+std2(B))/3;

% fprintf('\n   �ں�ͼ���׼��stdΪ:%.4f\n ',f);
end