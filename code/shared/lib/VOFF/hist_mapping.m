function High_PAN = hist_mapping(LRMS, PAN, sf, blockSize)
br = blockSize(1);
bc = blockSize(2);
[nr, nc, S] = size(LRMS);
[Nr, Nc]    = size(PAN);
High_PAN  = zeros(Nr, Nc, S);
while mod(nr, br)~=0 
    br = br-1;
end
while mod(nc, bc)~=0 
    bc = bc-1;
end
gridx = 1:br:nr-br+1; gridX = 1:sf*br:Nr-sf*br+1;
gridy = 1:bc:nc-bc+1; gridY = 1:sf*bc:Nc-sf*bc+1;
    for i=1:length(gridx)
        for j=1:length(gridy)
            High_PAN(gridX(i):gridX(i)+sf*br-1,gridY(j):gridY(j)+sf*bc-1,:)= mapping_block...
                (LRMS(gridx(i):gridx(i)+br-1,gridy(j):gridy(j)+bc-1,:), PAN(gridX(i):gridX(i)+sf*br-1,gridY(j):gridY(j)+sf*bc-1));
        end
    end
    
end