function [RT60] = findRT60(data,fs,rms_calibration)

%The first channel of data is the recording. The second channel is the digital input signal.
%So, for the calculation of RT60, we only use the first channel.
k=1;
for i=1:8*fs:fs*78
    dBchannel=94-20*log10(rms_calibration/rms(data(i:i+4*fs,1)));
    j=i+4*fs;
    flag=true;
    while flag==true
        j=j+480;    %Check every 0,01s.
        temp=94-20*log10(rms_calibration/rms(data(j:j+480,1)));
        if dBchannel-temp>5  %Wait until we have -5dB to start measuring.
            flag=false;             
        end
    end
    flag=true;
    start=j;
    while j<=i+8*fs  && flag==true           
        temp=94-20*log10(rms_calibration/rms(data(j:j+480,1)));
		%We are using T30 to calculate RT60, since we don't have the needed 60dB of dynamic range needed
		%for immediate calculation.
        if dBchannel-temp>=35
            RT60(k)=2*(j-start)/fs;
            k=k+1;
            flag=false;
        end
        j=j+480;    %Check every 0,01s.
    end
end

end

