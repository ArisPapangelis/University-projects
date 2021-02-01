;AVR running at 4 MHz.

.include "m16def.inc"

.def temp=r16
.def dc=r17
.def flag=r18

.org 0x0000

	rjmp RESET			;Reset vector


.org 0x0100

RESET:
	ldi flag,0			;Flag that decides whether to increase or decrease duty cycle

	ldi temp, high(RAMEND) 					;Main program start
	out SPH, temp							;Set stack pointer to top of RAM
	ldi temp, low(RAMEND)	
	out SPL, temp


	ldi temp, 0b1111_1111					;Set PB3(OC0) as output
	out DDRB,temp
		
	;Setting up PWM
	ldi dc,52								;20% duty cycle (52=~0,2 * 255)
	out OCR0,dc
	ldi temp, (1<<WGM00) | (1<<COM01) | (1<<CS00) 	;Phase correct PWM, non inverting
	out TCCR0,temp

REPEAT:
			
;Modifying duty cycle
	cpi flag,0			;If flag is 0, increase duty cycle by 5%, else decrease by 5%
	breq INCREASE_DC
				
	rjmp DECREASE_DC

INCREASE_DC:
	subi dc, -13		;Increase duty cycle by 5%.
	cpi dc,182			;Duty cycle will be 182 after 10 increases
	brne END

DELAY_10:				;Keep duty cycle steady for 10 sec. Executes after 10 consecutive increases
	ldi  r21, 203
    ldi  r22, 236
    ldi  r23, 133
L1: dec  r23
    brne L1
    dec  r22
    brne L1
    dec  r21
    brne L1
    nop
	
	
	ldi flag,1			;After being steady for 10 seconds, flag is set to 1 for the duty cycle to decrease

DECREASE_DC:
	subi dc,13			;Decrease duty cycle by 5%
	cpi dc,52			;Duty cycle will be 52 again after 10 decreases
	brne END
	ldi flag,0			;After 10 decreases, flag is set to 1 for the duty cycle to increase again


END:
	out OCR0,dc			;Write the new duty dycle

DELAY_400MS:			;Delay of 400 ms, between each duty cycle change
	ldi  r21, 9
    ldi  r22, 30
    ldi  r23, 229
L2: dec  r23
    brne L2
    dec  r22
    brne L2
    dec  r21
    brne L2
    nop
	
	rjmp REPEAT			;Jump to the code after the initialisations, for the next duty cycle step

