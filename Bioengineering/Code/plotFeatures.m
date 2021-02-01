function [  ] = plotFeatures(spikeClass, zeroPassings, pp )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

figure();
hold on;
length=size(spikeClass,2);
for i=1:length
    if spikeClass(i)==1
        color='r';
    elseif spikeClass(i)==2
        color='g';
    else
        color='b';
    end
    scatter(zeroPassings(i),pp(i),[],color);
end
hold off;
xlabel('Zero crossings'), ylabel('Peak to peak voltage'), title('Features');

end

