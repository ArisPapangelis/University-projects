%������ 2
clear all;
load('kModel.mat');
all_data=zeros(4,1440000);
for i=1:4
    load(['Data_Eval_E_',num2str(i),'.mat']);
    all_data(i,:)=data;
    if i==1
        spikeTimes1=spikeTimes;
        spikeClass1=spikeClass;
    elseif i==2
        spikeTimes2=spikeTimes;
        spikeClass2=spikeClass;
    elseif i==3
        spikeTimes3=spikeTimes;
        spikeClass3=spikeClass;
    else
        spikeTimes4=spikeTimes;
        spikeClass4=spikeClass;
    end
end

clear data;
clear spikeClass;
clear spikeTimes;

%������� 2.1
sn=zeros(1,4);
k=zeros(1,4);
T=zeros(1,4);
spikeNumsEst=zeros(1,4);
for i=1:4
    %figure(i);
    %plot(all_data(i,1:10000)), xlabel('Sample'), ylabel('mV'), title(['Data\_Eval\_E\_1',num2str(i),'.mat']);
    %saveas(gcf,['Data_Test_',num2str(i),'.png']);
    
    sn(i)=median(abs(all_data(i,:)))/0.6745; 
    k(i)=kModel(sn(i));
    T(i)=k(i)*sn(i);
end

[spikeTimesEst1,spikeNumsEst(1)] = findSpikes(all_data(1,:),T(1));
[spikeTimesEst2,spikeNumsEst(2)] = findSpikes(all_data(2,:),T(2));
[spikeTimesEst3,spikeNumsEst(3)] = findSpikes(all_data(3,:),T(3));
[spikeTimesEst4,spikeNumsEst(4)] = findSpikes(all_data(4,:),T(4));


%������� 2.2
range=64;

%1� ������
figure();
[spikesEst1] = estimateSpikes(spikeNumsEst(1),spikeTimesEst1,range,all_data(1,:));

%2� ������
figure();
[spikesEst2] = estimateSpikes(spikeNumsEst(2),spikeTimesEst2,range,all_data(2,:));

%3� ������
figure();
[spikesEst3] = estimateSpikes(spikeNumsEst(3),spikeTimesEst3,range,all_data(3,:));

%4� ������
figure();
[spikesEst4] = estimateSpikes(spikeNumsEst(4),spikeTimesEst4,range,all_data(4,:));


%������� 2.3
figure();
[spikeClassEst1, spikeDiff(1)] = estimateCorrectSpikes(spikeTimes1,spikeTimesEst1,spikeClass1,spikesEst1,range);
figure();
[~, spikeDiff(2),matchedSpikeIndices2] = estimateCorrectSpikes(spikeTimes2,spikeTimesEst2,spikeClass2,spikesEst2,range);
figure();
[~, spikeDiff(3),matchedSpikeIndices3] = estimateCorrectSpikes(spikeTimes3,spikeTimesEst3,spikeClass3,spikesEst3,range);
figure();
[~, spikeDiff(4),matchedSpikeIndices4] = estimateCorrectSpikes(spikeTimes4,spikeTimesEst4,spikeClass4,spikesEst4,range);
 
%������� 2.4 ��� 2.5

%������� ��������� ��� �� 0.
zeroPassings1=calculateZeroPassings(spikesEst1,range);
zeroPassings2=calculateZeroPassings(spikesEst2(matchedSpikeIndices2,:),range);
zeroPassings3=calculateZeroPassings(spikesEst3(matchedSpikeIndices3,:),range);
zeroPassings4=calculateZeroPassings(spikesEst4(matchedSpikeIndices4,:),range);

%������� peak to peak ������ ������������
pp1=peak2peak(spikesEst1,2);
pp2=peak2peak(spikesEst2(matchedSpikeIndices2,:),2);
pp3=peak2peak(spikesEst3(matchedSpikeIndices3,:),2);
pp4=peak2peak(spikesEst4(matchedSpikeIndices4,:),2);

%1� ������
Data1(:,1)=zeroPassings1';
Data1(:,2)=pp1;
Group1=spikeClassEst1';
plotFeatures(spikeClassEst1, zeroPassings1, pp1);

Data1(:,3)= sum(spikesEst1,2);  %�������� ��� ����� ���� ��� ��������� ���� ���� �����������.
Data1(:,4)= min(spikesEst1,[],2); %�������� ������������.
Data1(:,5)= meanfreq(spikesEst1'); %���� ��������� ������������.
Data1(:,6)= rssq(spikesEst1,2); %Root sum of squares ��� ������������.
Data1(:,7)= peak2rms(spikesEst1,2);  %����� �������� ���� RMS.
Data1(:,8)= var(spikesEst1,0,2);    %���������� ������������.
Data1(:,9)= std(spikesEst1,0,2);    %������ �������� ������������.
percentage1=MyClassify(Data1,Group1);

%2� ������
Data2(:,1)=zeroPassings2';
Data2(:,2)=pp2;
Group2=spikeClass2';
plotFeatures(spikeClass2, zeroPassings2, pp2);

Data2(:,3)=sum(spikesEst2(matchedSpikeIndices2,:),2);   %�������� ��� ����� ���� ��� ��������� ���� ���� �����������.
Data2(:,4)=min(spikesEst2(matchedSpikeIndices2,:),[],2);    %�������� ������������.
Data2(:,5)= meanfreq(spikesEst2(matchedSpikeIndices2,:)'); %���� ��������� ������������.
Data2(:,6)= rssq(spikesEst2(matchedSpikeIndices2,:),2); %Root sum of squares ��� ������������.
Data2(:,7)= peak2rms(spikesEst2(matchedSpikeIndices2,:),2);  %����� �������� ���� RMS.
Data2(:,8)= var(spikesEst2(matchedSpikeIndices2,:),0,2);    %���������� ������������.
Data2(:,9)= std(spikesEst2(matchedSpikeIndices2,:),0,2);    %������ �������� ������������.
percentage2=MyClassify(Data2,Group2);

%3� ������
Data3(:,1)=zeroPassings3';
Data3(:,2)=pp3;
Group3=spikeClass3';
plotFeatures(spikeClass3, zeroPassings3, pp3);

Data3(:,3)=sum(spikesEst3(matchedSpikeIndices3,:),2);   %�������� ��� ����� ���� ��� ��������� ���� ���� �����������.
Data3(:,4)=min(spikesEst3(matchedSpikeIndices3,:),[],2);    %�������� ������������.
Data3(:,5)= meanfreq(spikesEst3(matchedSpikeIndices3,:)'); %���� ��������� ������������.
Data3(:,6)= rssq(spikesEst3(matchedSpikeIndices3,:),2); %Root sum of squares ��� ������������.
Data3(:,7)= peak2rms(spikesEst3(matchedSpikeIndices3,:),2);  %����� �������� ���� RMS.
Data3(:,8)= var(spikesEst3(matchedSpikeIndices3,:),0,2);    %���������� ������������.
Data3(:,9)= std(spikesEst3(matchedSpikeIndices3,:),0,2);    %������ �������� ������������.
percentage3=MyClassify(Data3,Group3);

%4� ������
Data4(:,1)=zeroPassings4';
Data4(:,2)=pp4;
Group4=spikeClass4';
plotFeatures(spikeClass4, zeroPassings4, pp4);

Data4(:,3)=sum(spikesEst4(matchedSpikeIndices4,:),2);   %�������� ��� ����� ���� ��� ��������� ���� ���� �����������.
Data4(:,4)=min(spikesEst4(matchedSpikeIndices4,:),[],2);    %�������� ������������.
Data4(:,5)= meanfreq(spikesEst4(matchedSpikeIndices4,:)'); %���� ��������� ������������.
Data4(:,6)= rssq(spikesEst4(matchedSpikeIndices4,:),2); %Root sum of squares ��� ������������.
Data4(:,7)= peak2rms(spikesEst4(matchedSpikeIndices4,:),2);  %����� �������� ���� RMS.
Data4(:,8)= var(spikesEst4(matchedSpikeIndices4,:),0,2);    %���������� ������������.
Data4(:,9)= std(spikesEst4(matchedSpikeIndices4,:),0,2);    %������ �������� ������������.
percentage4=MyClassify(Data4,Group4);




    
