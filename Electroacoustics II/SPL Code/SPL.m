fs=48000;
[calibration]=audioread('calibration-24 bits.wav',[4*fs+1, 9*fs]);
[data001]=audioread('001.wav',[1, 5*fs]);
[data007]=audioread('007.wav',[1, 5*fs]);
[data008]=audioread('008.wav',[1, 5*fs]);
[data014]=audioread('014.wav',[1, 5*fs]);
[data017]=audioread('017.wav',[1, 5*fs]);
[data021]=audioread('021.wav',[1, 5*fs]);
[data024]=audioread('024.wav',[1, 5*fs]);
[data031]=audioread('031.wav',[1, 5*fs]);
[data033]=audioread('033.wav',[1, 5*fs]);


rms_calibration=rms(calibration);   %This was calibrated at 94 dB, 1000hz.

%Octave filtering.
fcentre=[31.5 63 125 250 500 1000 2000 4000 8000 16000];
for i=1:size(fcentre,2)
    octFilt = octaveFilter(fcentre(i),'1 octave','SampleRate',fs);
    
    %filtered_background_noise(:,i)=octFilt(background_noise);
    filtered_data001(:,i)=octFilt(data001);
    filtered_data007(:,i)=octFilt(data007);
    filtered_data008(:,i)=octFilt(data008);
    filtered_data014(:,i)=octFilt(data014);
    filtered_data017(:,i)=octFilt(data017);
    filtered_data021(:,i)=octFilt(data021);
    filtered_data024(:,i)=octFilt(data024);
    filtered_data031(:,i)=octFilt(data031);
    filtered_data033(:,i)=octFilt(data033);
    %filtered_dataomni(:,i)=octFilt(dataomni); 
end

dB001=0;
dB007=0;
dB008=0;
dB014=0;
dB017=0;
dB021=0;
dB024=0;
dB031=0;
dB033=0;

%Zero weighted SPL, per octave.
for i=1:size(fcentre,2)
    dB001_oct(i)=94-20*log10(rms_calibration/rms(filtered_data001(:,i)));
    dB007_oct(i)=94-20*log10(rms_calibration/rms(filtered_data007(:,i)));
    dB008_oct(i)=94-20*log10(rms_calibration/rms(filtered_data008(:,i)));
    dB014_oct(i)=94-20*log10(rms_calibration/rms(filtered_data014(:,i)));
    dB017_oct(i)=94-20*log10(rms_calibration/rms(filtered_data017(:,i)));
    dB021_oct(i)=94-20*log10(rms_calibration/rms(filtered_data021(:,i)));
    dB024_oct(i)=94-20*log10(rms_calibration/rms(filtered_data024(:,i)));
    dB031_oct(i)=94-20*log10(rms_calibration/rms(filtered_data031(:,i)));
    dB033_oct(i)=94-20*log10(rms_calibration/rms(filtered_data033(:,i)));
    
    %Logarithmic summation of the sound pressure levels per octave
    dB001=dB001+10^(dB001_oct(i)/10);
    dB007=dB007+10^(dB007_oct(i)/10);
    dB008=dB008+10^(dB008_oct(i)/10);
    dB014=dB014+10^(dB014_oct(i)/10);
    dB017=dB017+10^(dB017_oct(i)/10);
    dB021=dB021+10^(dB021_oct(i)/10);
    dB024=dB024+10^(dB024_oct(i)/10);
    dB031=dB031+10^(dB031_oct(i)/10);
    dB033=dB033+10^(dB033_oct(i)/10);
end

%Mean SPL per octave for the entire room.
meandB_oct=(dB001_oct+dB007_oct+dB008_oct+dB014_oct+dB017_oct+dB021_oct+dB024_oct+dB031_oct+dB033_oct)/9;

dB001=10*log10(dB001);
dB007=10*log10(dB007);
dB008=10*log10(dB008);
dB014=10*log10(dB014);
dB017=10*log10(dB017);
dB021=10*log10(dB021);
dB024=10*log10(dB024);
dB031=10*log10(dB031);
dB033=10*log10(dB033);

plot(fcentre,meandB_oct), xlabel('Frequency(Hz)'), ylabel('dB (SPL)');



