function [Dictionary,output]=Train_dictionary(I1,I2)
I1 = double(I1); 
I2 = double(I2); 
tic

D=I1;
index=find(I2>I1);
D(index)=I2(index);     % using maximum stratege to combine the 2 images
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
blkMatrix = im2col(double(D),[bb,bb],'sliding');
param.K = K;
param.numIteration = numIterOfKsvd ;

param.errorFlag = 1; % decompose signals until a certain error is reached. do not use fix number of coefficients.
param.preserveDCAtom = 0;

Pn=ceil(sqrt(K));
DCT=zeros(bb,Pn); 
for k=0:1:Pn-1,
    V=cos([0:1:bb-1]'*k*pi/Pn);
    if k>0, V=V-mean(V); end;
    DCT(:,k+1)=V/norm(V);
end;
DCT=kron(DCT,DCT);

param.initialDictionary = DCT(:,1:param.K );
param.InitializationMethod =  'GivenMatrix';

if (Reduce_DC)
    vecOfMeans = mean(blkMatrix);
    blkMatrix = blkMatrix-ones(size(blkMatrix,1),1)*vecOfMeans;
end

param.displayProgress = displayFlag;
[Dictionary,output] = KSVD(blkMatrix,param);
output.D = Dictionary;


 