function [spikesEst] = estimateSpikes( spikeNumsEst, spikeTimesEst, range, data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

spikesEst=zeros(spikeNumsEst,range);
for i=1:spikeNumsEst
    %offset=0;
    [valley,minIndex]=min(data(spikeTimesEst(i)-range/2:spikeTimesEst(i)+range/2));
    [peak,maxIndex]=max(data(spikeTimesEst(i)-range/2:spikeTimesEst(i)+range/2));
    if maxIndex<minIndex
        offset=abs(maxIndex-range/2);
        spikesEst(i,:)=data(spikeTimesEst(i)+offset-range/2:spikeTimesEst(i)+offset+range/2-1);
    else
        offset=range/2-minIndex;
        spikesEst(i,:)=data(spikeTimesEst(i)-offset-range/2:spikeTimesEst(i)-offset+range/2-1);
    end
    
    %if valley<-T
       % offset=range/2-index;
   % end
    %spikesEst(i,:)=data(spikeTimesEst(i)-offset-range/2:spikeTimesEst(i)-offset+range/2-1); 
end

%spikesEst=sortrows(spikesEst,-(range/2+1));
hold on
for i=1:spikeNumsEst
    plot(1:range,spikesEst(i,:));
end
hold off
xlabel('Sample'), ylabel('mV'), title('Spike waveforms');
end

