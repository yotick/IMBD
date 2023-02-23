function out = saliance(Ahigh, Bhigh, alpha)

b1=mean(mean(Ahigh));
b2=mean(mean(Bhigh));
% b=(b1+b2)/2;
a1=min(min(Ahigh));
a2=min(min(Bhigh));
% a=min(a1,a2);
UA=1-gbellmf(Ahigh,[a1,1,b1]);
UB=1-gbellmf(Bhigh,[a2,1,b2]);

% UA = stdfilt(Ahigh);
% UB = stdfilt(Bhigh);

for i = 1:size(UA,1)
    for j = 1:size(UA,2)
        if UA(i,j) > UB(i,j)
            out(i,j) = alpha*Ahigh(i,j)+(1-alpha)*Bhigh(i,j);
        else
            out(i,j) = alpha*Bhigh(i,j)+(1-alpha)*Ahigh(i,j);
        end
    end
end
% imshow(UA*1.2);
% figure,imshow(UB*1.2);
% figure,imshow(out*2+0.1);
% figure, imshow(Ahigh*2+0.1);
% figure, imshow(Bhigh*30+0.1);
% UA = sigmf(Ahigh, [1,b1]);

end