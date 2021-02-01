fs=48000;
load('RT60classic.mat');
[calibration,fs]=audioread('calibration.wav',[4*fs+1, 9*fs]);
[background_noise]=audioread('background-noise-random-position.wav');
background_noise(size(background_noise,1)+1:516000)=background_noise(1:516000-size(background_noise,1));


[data001]=audioread('Pos01-SS-01.wav',[1, 10.75*fs] );
[data007]=audioread('Pos07-SS-00.wav',[1, 10.75*fs] );
[data017]=audioread('Pos17-SS-00.wav',[1, 10.75*fs] );
[data021]=audioread('Pos21-SS-00.wav',[1, 10.75*fs] );
[data031]=audioread('Pos31-SS-00.wav',[1, 10.75*fs] );
[dataomni]=audioread('Pos01-SS-01-omni.wav',[1, 10.75*fs] );

%[data]=audioread('Pos01-IN.wav',[1, 78*fs] );

%Calculation of the impulse response in the frequency domain through fourier transformation.
ht1=fft(data001(:,1))./fft(data001(:,2));
ht7=fft(data007(:,1))./fft(data007(:,2));
ht17=fft(data017(:,1))./fft(data017(:,2));
ht21=fft(data021(:,1))./fft(data021(:,2));
ht31=fft(data031(:,1))./fft(data031(:,2));
htomni=fft(dataomni(:,1))./fft(dataomni(:,2));

%Octave filtering and reverse transformation to the time domain.
fcentre=[100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000];

for i=1:size(fcentre,2)
    octFilt = octaveFilter(fcentre(i),'1/3 octave','SampleRate',fs);
    
    filtered_background_noise(:,i)=octFilt(background_noise);
    filtered_ht1(:,i)=octFilt(ifft(ht1));
    filtered_ht7(:,i)=octFilt(ifft(ht7));
    filtered_ht17(:,i)=octFilt(ifft(ht17));
    filtered_ht21(:,i)=octFilt(ifft(ht21));
    filtered_ht31(:,i)=octFilt(ifft(ht31));
    filtered_htomni(:,i)=octFilt(ifft(htomni));
    
	%Calculation of RT60 in the current 1/3 octave band.
    RT60_001(i)=findRT60_SS(filtered_ht1(:,i),fs,RT60_room(i));
    RT60_007(i)=findRT60_SS(filtered_ht7(:,i),fs,RT60_room(i));
    RT60_017(i)=findRT60_SS(filtered_ht17(:,i),fs,RT60_room(i));
    RT60_021(i)=findRT60_SS(filtered_ht21(:,i),fs,RT60_room(i));
    RT60_031(i)=findRT60_SS(filtered_ht31(:,i),fs,RT60_room(i));
    RT60_new(i)= (RT60_001(i)+RT60_007(i)+RT60_017(i)+RT60_021(i)+RT60_031(i))/5;	%Spatial averaging for the room.
end
RT60=mean(RT60_new(7:12));	%Averaging of the six 1/3 octave bands from 400Hz to 1250Hz, as instructed by ISO 3382:2009.
plot(fcentre,RT60_new), xlabel('Frequency(Hz)'), ylabel('Time(s)');

