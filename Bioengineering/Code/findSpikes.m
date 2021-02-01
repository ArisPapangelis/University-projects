function [ spikeTimesEst, spikeNumsEst ] = findSpikes( data, T )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
flag=false;
j=1;
for i=1:1440000
    if data(i)>=T && flag == false
        spikeTimesEst(j)=i;
        flag=true;
        j=j+1;
    elseif data(i)<=T && flag==true
        flag=false;
    end
end
spikeNumsEst = size(spikeTimesEst,2);

end

