fs=48000;
[fcentre] = [125 250 500 1000 2000 4000 8000]; %Center frequencies for octave filters


%impulse responses found by deconvolution of the swept sine 
%channel 1 = received signal, channel 2 = source

[data001]=audioread('Pos01-SS-01.wav',[1, 10.75*fs] );
[data007]=audioread('Pos07-SS-00.wav',[1, 10.75*fs] );
[data017]=audioread('Pos17-SS-00.wav',[1, 10.75*fs] );
[data021]=audioread('Pos21-SS-00.wav',[1, 10.75*fs] );
[data031]=audioread('Pos31-SS-00.wav',[1, 10.75*fs] );
[dataomni]=audioread('Pos01-SS-01-omni.wav',[1, 10.75*fs] );

ir1=ifft(fft(data001(:,1))./fft(data001(:,2)));
ir7=ifft(fft(data007(:,1))./fft(data007(:,2)));
ir17=ifft(fft(data017(:,1))./fft(data017(:,2)));
ir21=ifft(fft(data021(:,1))./fft(data021(:,2)));
ir31=ifft(fft(data031(:,1))./fft(data031(:,2)));
iromni=ifft(fft(dataomni(:,1))./fft(dataomni(:,2)));


% Filtering each channel's impulse response 

for i=1:size(fcentre,2)
    octFilt = octaveFilter(fcentre(i),'1 octave','SampleRate',fs);
    
    %filtered_background_noise(:,i)=octFilt(background_noise);
    filtered_ir1(:,i)=octFilt(ir1);
    filtered_ir7(:,i)=octFilt(ir7);
    filtered_ir17(:,i)=octFilt(ir17);
    filtered_ir21(:,i)=octFilt(ir21);
    filtered_ir31(:,i)=octFilt(ir31);
    filtered_iromni(:,i)=octFilt(iromni);
    
end



%Finding MTFs for the six positions

for i=1:size(fcentre,2)
    MTF_Pos01(:,i) = getMTF_indirect(filtered_ir1(:,i)); %Position 1, Each loop for every octaveband
    MTF_Pos07(:,i) = getMTF_indirect(filtered_ir7(:,i));
    MTF_Pos17(:,i) = getMTF_indirect(filtered_ir17(:,i));
    MTF_Pos21(:,i) = getMTF_indirect(filtered_ir21(:,i));
    MTF_Pos31(:,i) = getMTF_indirect(filtered_ir31(:,i));
    MTF_omni(:,i) = getMTF_indirect(filtered_iromni(:,i));
end

STIPAv(1)= STIPAcalc(MTF_Pos01,fs);  %Positions 1-->6 stand for 1, 7, 17, 21, 31, 1(omni)
STIPAv(2)= STIPAcalc(MTF_Pos07,fs);
STIPAv(3)= STIPAcalc(MTF_Pos17,fs);
STIPAv(4)= STIPAcalc(MTF_Pos21,fs);
STIPAv(5)= STIPAcalc(MTF_Pos31,fs);
STIPAv(6)= STIPAcalc(MTF_omni,fs);


for i=1:6
    ALcons(i) = 170.5405 * exp(-5.419*STIPAv(i)); %Calculating Articulation of Consonants Loss (Percentages)
end




