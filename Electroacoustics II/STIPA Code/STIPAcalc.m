function [STIPAv] = STIPAcalc (MTF_xp, fs)

freqs = linspace(0, fs/2, size(MTF_xp,1)/2+1); freqs(end)=[];%No nyquist frequency

[mod_freq]= [1.6, 8, 1, 5, 0.63, 3.15, 2, 10,  1.25, 6.25, 0.8, 4, 2.5, 12.5]; % STIPA Modulation Frequencies
[W]=[0.13  0.14  0.11  0.12  0.19  0.17  0.14]; %Weighting factors for 7 octaves

k=1;
for i=1:7
    
    m(i,1) = interp1(freqs,MTF_xp(1:end/2,i),mod_freq(k));
    m(i,2) = interp1(freqs,MTF_xp(1:end/2,i),mod_freq(k+1));
    
  k = k+2 ;
end


SNR_apparent = 10*log10( m ./ (1-m) );

SNR_apparent( SNR_apparent > 15 ) = 15;      %Limiting the range to 30dB as required
SNR_apparent( SNR_apparent < -15 ) = -15;

SNR_avg = mean(SNR_apparent,2);    %Finding average value for each of the seven octaves (out of 2)

SNR_Wavg = sum(SNR_avg' .* W);

[STIPAv]  = (SNR_Wavg + 15) / 30;






