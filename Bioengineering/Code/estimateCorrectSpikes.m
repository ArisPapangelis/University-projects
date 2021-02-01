function [ spikeClassEst, spikeDiff, matchedSpikeIndices ] = estimateCorrectSpikes( spikeTimes, spikeTimesEst, spikeClass, spikesEst,range )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%{
j=1;
spikeClassEst=zeros(1,size(spikeTimesEst,2));
while j<=size(spikeTimesEst,2)
    [~,index]=min(abs(spikeTimesEst(j)-spikeTimes(:)));
    spikeClassEst(j)=spikeClass(index);
    j=j+1;
end
%}

if size(spikeTimesEst,2)<size(spikeTimes,2)
    spikeClassEst=zeros(1,size(spikeTimesEst,2));
    hold on;
    for j=1:size(spikeTimesEst,2)
        [~,index]=min(abs(spikeTimesEst(j)-spikeTimes(:)));
        spikeClassEst(j)=spikeClass(index);
        if spikeClassEst(j)==1
            color='r';
        elseif spikeClassEst(j)==2
            color='g';
        else
            color='b';
        end
        plot(1:range,spikesEst(j,:),'Color',color);        
    end
    hold off;
else
    spikeClassEst=zeros(1,size(spikeTimesEst,2));
    matchedSpikeIndices=zeros(1,size(spikeTimes,2));
    hold on;
    for j=1:size(spikeTimes,2)
        [~,index]=min(abs(spikeTimes(j)-spikeTimesEst(:)));
        matchedSpikeIndices(j)=index;
        if spikeClass(j)==1
            color='r';
        elseif spikeClass(j)==2
            color='g';
        else
            color='b';
        end
        plot(1:range,spikesEst(index,:),'Color',color);        
    end
    hold off;
    xlabel('Sample'), ylabel('mV'), title('Spike waveforms, coloured');
end

%{    
hold on
for i=1:size(spikeTimesEst,2)
    if spikeClassEst(i)==1
        color='r';
    elseif spikeClassEst(i)==2
        color='g';
    else
        color='b';
    end
    plot(1:range,spikesEst(i,:),'Color',color);
end
hold off
%}
    
spikeDiff=size(spikeTimesEst,2)-size(spikeTimes,2);
end


