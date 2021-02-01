function [ zeroPassings ] = calculateZeroPassings( spikesEst, range)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

length=size(spikesEst,1);
zeroPassings = zeros(1,length);
for i=1:length
    for j=2:range-1
        if (spikesEst(i,j-1)<=0 && spikesEst(i,j)>0) || (spikesEst(i,j-1)>0 && spikesEst(i,j)<=0)
            zeroPassings(i)=zeroPassings(i)+1;
        end
    end
end

