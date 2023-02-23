function fused=sparsefusion_KSVD(I1,I2,Dictionary)
I1 = double(I1); 
I2 = double(I2); 
tic

% D=I1;
% index=find(I2>I1);
% D(index)=I2(index);
 param = struct('Reduce_DC', 1,'blockSize', 8, 'DictionarySize', 256, 'errorGoal', 0.05);

Reduce_DC = 1;
[NN1,NN2] = size(I1);
maxBlocksToConsider = 260000;
slidingDis = 1;
bb = param.blockSize;
K = param.DictionarySize;
numIterOfKsvd = 5;
maxNumBlocksToTrainOn = 65000;
displayFlag = 1;
% blkMatrix = im2col(double(D),[bb,bb],'sliding');
param.K = K;
param.numIteration = numIterOfKsvd ;

param.errorFlag = 1; % decompose signals until a certain error is reached. do not use fix number of coefficients.
param.preserveDCAtom = 0;

Pn=ceil(sqrt(K));
% denoise the image using the resulted dictionary
errT = param.errorGoal;

% Transform the source images into blocks
blocks1 = my_im2col(I1,[bb,bb],slidingDis);  % 图像分块后，每块排成一列，全部块排成一个矩阵
idx1 = [1:size(blocks1,2)];                  % size（A,2）：求矩阵A的列数
blocks2 = my_im2col(I2,[bb,bb],slidingDis);
idx2 = [1:size(blocks2,2)];

if (Reduce_DC)
    vecOfMeans1 = mean(blocks1);
    blocks1 = blocks1 - repmat(vecOfMeans1,size(blocks1,1),1);  
    vecOfMeans2 = mean(blocks2);
    blocks2 = blocks2 - repmat(vecOfMeans2,size(blocks2,1),1);        
end  

A1 = OMPerr(Dictionary,blocks1,errT);
A2 = OMPerr(Dictionary,blocks2,errT);

% == The fusing process == %
A=A2;
index=find(abs(A1)>abs(A2));
A(index)=A1(index);        

if (Reduce_DC)
    blocks= Dictionary*A + ones(size(blocks1,1),1) * (vecOfMeans1+vecOfMeans2)/2;
else
    blocks(:,jj:jumpSize) = Dictionary*A;
end

count = 1;
Weight= zeros(NN1,NN2);
IMout = zeros(NN1,NN2);
[rows,cols] = ind2sub(size(I1)-bb+1,idx1);
for i  = 1:length(cols)
    col = cols(i); row = rows(i);
    block =reshape(blocks(:,count),[bb,bb]);
    IMout(row:row+bb-1,col:col+bb-1)=IMout(row:row+bb-1,col:col+bb-1)+block;
    Weight(row:row+bb-1,col:col+bb-1)=Weight(row:row+bb-1,col:col+bb-1)+ones(bb);
    count = count+1;
end;

IOut = IMout./Weight;
fused=IOut;