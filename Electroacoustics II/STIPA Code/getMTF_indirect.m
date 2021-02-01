function [MTF]= getMTF_indirect(ir)


ir_2=ir.^2;
ir_2_int = sum(ir_2);   %integration (sum) of squared impulse response
IR_2_fft = fft(ir_2);  %Fourier transform of squared impulse response

IR_MTF = IR_2_fft / ir_2_int; %normalization-divide with energy(integral)
MTF=abs(IR_MTF);
plot(abs(IR_MTF))

