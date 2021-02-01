%’σκηση 1
all_data=zeros(8,1440000);
spikeNums=zeros(1,8);
for i=1:8
    load(['Data_Test_',num2str(i),'.mat']);
    all_data(i,:)=data;
    spikeNums(i)=spikeNum;
end


clear data;
clear spikeNum;

%Ερώτημα 1.1
for i=1:8
    figure(i);
    plot(all_data(i,1:10000)), xlabel('Sample'), ylabel('mV'), title(['Data\_Test\_',num2str(i),'.mat']);
    saveas(gcf,['Data_Test_',num2str(i),'.png']);
end


%Ερώτημα 1.2
sn=zeros(1,8);
for i=1:8
    sn(i)=median(abs(all_data(i,:)))/0.6745;   
end

step=0.005;
ending=4;
countedSpikes=zeros(8,ending/step);
for i=1:8
    x=1;
    for k = step:step:ending
        for j=2:1440000
            if (all_data(i,j) >= k*sn(i) && all_data(i,j-1)<k*sn(i))
                countedSpikes(i,x)=countedSpikes(i,x)+1;
            end 
        end
        x=x+1;
    end
end



for i=1:8
    figure(8+i);
    plot(0.005:0.005:4,countedSpikes(i,:)), xlabel('k'), ylabel('Number of spikes'), title(['Number of spikes vs k\_',num2str(i)]);
    saveas(gcf,['Number of spikes vs k_',num2str(i),'.png']);
end

%Ερώτημα 1.3
bestK=zeros(1,8);
for i=1:8
    k=step;
    min=1000000;
    for j=1:800
        if abs(spikeNums(i)-countedSpikes(i,j))<min
            min=abs(spikeNums(i)-countedSpikes(i,j));
            bestK(i)=k;
        end
        k=k+step;
    end
end

figure(17);
plot(sn,bestK), xlabel('σ_n'), ylabel('Best k'), title('Best k vs σ_n');

[kModel,gof]=createFit(sn,bestK);

save('kModel.mat', 'kModel', 'gof');



