function [RT60] = findRT60_SS(data,fs,rt)

%The parameter data is the impulse response in the particular octave band.
%The parameter rt is the reverberation time from the classic method.

%The step 480 is used since it is one hundredth (1/100) of the sampling rate,fs.
%Which is to say, our accuracy will be within 0,01 seconds.

for i=1:480:ceil(rt*fs)	%rt*fs is used empirically as the integration limit. We found it achieves acceptable accuracy.

	%Integration of the impulse response, as instructed by ISO 18233:2006
    dB=10*log10(trapz(data(1:ceil(rt*fs)).^2)/trapz(data(i:ceil(rt*fs),1).^2));
    if dB>5			%Wait until -5 dB to start measuring.
        start=i;
        break;
    end
end

for i=start:480:ceil(rt*fs)
    dB=10*log10(trapz(data(1:ceil(rt*fs)).^2)/trapz(data(i:ceil(rt*fs),1).^2));
    if dB>35	%-35dB is what we need for T30.
        RT60=2*(i-start)/fs;
        break;
    end
end

end

