fs=48000;

[calibration,fs]=audioread('calibration.wav',[4*fs+1, 9*fs]);
[background_noise]=audioread('background-noise-random-position.wav');

[data001]=audioread('Pos01-IN.wav',[1, 78*fs] );
[data007]=audioread('Pos07-IN.wav',[1, 78*fs] );
[data017]=audioread('Pos17-IN.wav',[1, 78*fs] );
[data021]=audioread('Pos21-IN.wav',[1, 78*fs] );
[data031]=audioread('Pos31-IN.wav',[1, 78*fs] );
[dataomni]=audioread('Pos01-IN-01-omni.wav',[1, 78*fs] );

%Octave filtering.
k=1;
%fcentre=[125 250 500 1000 2000 4000 8000 16000];
fcentre=[100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000];
%fcentre = 10.^(0.1.*[20:40]);
for i=1:size(fcentre,2)
    octFilt = octaveFilter(fcentre(i),'1/3 octave','SampleRate',fs);
    
    %filtered_background_noise(:,i)=octFilt(background_noise);
    filtered_data001(:,k:k+1)=octFilt(data001);
    filtered_data007(:,k:k+1)=octFilt(data007);
    filtered_data017(:,k:k+1)=octFilt(data017);
    filtered_data021(:,k:k+1)=octFilt(data021);
    filtered_data031(:,k:k+1)=octFilt(data031);
    %filtered_dataomni(:,k:k+1)=octFilt(dataomni);
    k=k+2;
end

clear data001 data007 data017 data021 data031 dataomni;

rms_calibration=rms(calibration);   %This was calibrated at 94 dB (1000 hz tone).
rms_bgnoise=rms(background_noise);

dBNoise=94-20*log10(rms_calibration/rms_bgnoise);

%Calculation of RT60 for each position, through the averaging of the result of all interrupted noise cycles.
%For the reverberation time of the entire room, we employ the spatial averaging of the results from each position.
i=1;
while i<=2*size(fcentre,2)
    %RT60_omni(ceil(i/2))=mean(2*findRT60(filtered_dataomni(:,i:i+1),fs,rms_calibration));
    RT60_001(ceil(i/2))=mean(findRT60(filtered_data001(:,i:i+1),fs,rms_calibration));
    RT60_007(ceil(i/2))=mean(findRT60(filtered_data007(:,i:i+1),fs,rms_calibration));
    RT60_017(ceil(i/2))=mean(findRT60(filtered_data017(:,i:i+1),fs,rms_calibration));
    RT60_021(ceil(i/2))=mean(findRT60(filtered_data021(:,i:i+1),fs,rms_calibration));
    RT60_031(ceil(i/2))=mean(findRT60(filtered_data031(:,i:i+1),fs,rms_calibration));
    RT60_room(ceil(i/2))= (RT60_001(ceil(i/2))+RT60_007(ceil(i/2))+RT60_017(ceil(i/2))+RT60_021(ceil(i/2))+RT60_031(ceil(i/2)))/5;
    i=i+2;
end

RT60=mean(RT60_room(7:12));		%Averaging of the six 1/3 octave bands from 400Hz to 1250Hz, as instructed by ISO 3382:2009.
plot(fcentre,RT60_room), xlabel('Frequency(Hz)'), ylabel('Time(s)');
save('RT60classic.mat','RT60_room');	%Saved for use in the calculation of RT60 through the swept sine method.
