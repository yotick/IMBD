function y=nsst_fuse(I1,I2)

%    NSST-SR
%    Input:
%    I1 - input image A
%    I2 - input image B
%    nlevels - number of directions in each decomposition level
%    D  - Dictionary for sparse representation
%    overlap - the overlapped pixels between two neighbor patches
%    epsilon - sparse reconstuction error
%    Output:
%    y  - fused image

[m,n]=size(I1);
shear = shearing_filters_Myer([30 40 60],[2 3 4],[m,n]);
% shear = shearing_filters_Myer([30 30 36 36],[3 3 4 4],[m,n]);

d1=shear_trans(I1,'pyrexc',shear);    %shearlet系数  maxflat or pyrexc
d2=shear_trans(I2,'pyrexc',shear);
% apply forward shearlet transform.
Fused=d1;
%以下进行系数的融合
Alow=d1{1};
Blow=d2{1};

% Fused{1} = sparsefusion_KSVD(Alow,Blow,overlap,epsilon);
% Fused{1} = Alow;

EA=getgrad(Alow);
EB=getgrad(Blow);
x=EA./EB;
K=100;
w=zeros(m,n);
for i=1:m
    for j=1:n
        y=0;
        for k=1:K
            y=y+(-1)^(k-1)*x(i,j)^(K-k);
        end
        if x(i,j)>0 && x(i,j)<1
           w(i,j)=x(i,j)^K /(x(i,j)^K +y);
        elseif x(i,j)>=1
               w(i,j)= y/(1+y);
        end 
    end
end
Fused{1}(i,j)=w(i,j)*Alow(i,j)+(1-w(i,j))*Blow(i,j);

for s = 2:length(d1)
    for w = 1:size(d1{s},3)
        Ahigh = d1{s}(:,:,w);
        Bhigh = d2{s}(:,:,w);
%         decision_map=(abs(Ahigh)>=abs(Bhigh));
%         Fused{s}(:,:,w)=decision_map.*Ahigh + (~decision_map).*Bhigh;

%         EA=energe(Ahigh);
%         EB=energe(Bhigh);
%         decision_map=(abs(EA)>=abs(EB));
%         Fused{s}(:,:,w)=decision_map.*Ahigh + (~decision_map).*Bhigh;
        
        SFA=SF(Ahigh);
        SFB=SF(Bhigh);
        decision_map=(abs(SFA)>=abs(SFB));
        Fused{s}(:,:,w)=decision_map.*Ahigh + (~decision_map).*Bhigh;

%         SMLA=getSML(Ahigh,window);
%         SMLB=getSML(Bhigh,window);
%         decision_map=(abs(SMLA)>=abs(SMLB));
%         Fused{s}(:,:,w)=decision_map.*Ahigh + (~decision_map).*Bhigh;
    end
end

% 以下进行shearlet逆变换
% apply inverse shearlet transform.
y = inverse_shear(Fused,'pyrexc',shear);

end
