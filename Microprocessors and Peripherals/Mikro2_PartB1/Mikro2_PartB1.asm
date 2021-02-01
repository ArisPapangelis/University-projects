;AVR running at 4 MHz.

.include "m16def.inc"

.def temp=r16
.def duration=r17
.def dc=r18

.org 0x0000

	rjmp RESET				;Reset vector

.org 0x0002

	rjmp EXT_INT0_ISR		;External interrupt 0 interrupt vector

.org 0x000C
	
	rjmp TIMER_COMPA_ISR	;Output compare timer 1A interrupt vector

.org 0x0100

RESET:

	ldi temp, high(RAMEND) 					;Main program start
	out SPH, temp							;Set stack pointer to top of RAM
	ldi temp, low(RAMEND)	
	out SPL, temp

	ldi temp, 0b1111_1011					
	out DDRD, temp							;Set PD5(OC1A) as output, PD2(INT0) as input
	
	
	ser temp
	out DDRA,temp							;Port A as leds
	out PORTA,temp
	
	clr temp
	out DDRC,temp							;Port C as switches

	ldi temp, 0b1111_1111					;Set PB3(OC0) as output
	out DDRB,temp
		
	;Setting up PWM
	ldi dc,51								;20% duty cycle (51=0,2 * 255)
	out OCR0,dc
	ldi temp, (1<<WGM00) | (1<<COM01) | (1<<CS00) 	;Phase correct PWM, non inverting
	out TCCR0,temp

REPEAT:
	ldi XL,0					;Used as count of pulses
	ldi XH,0

	ldi duration,0

	
	ldi temp, (1 << ISC01)		;Falling edge interrupts on external interrupt 0.
	out MCUCR,temp

	ldi temp,(1<<INT0)			;External interrupt 0 enable
	out GICR,temp


	;Count number of pulses in 1 sec
	;Set TCNT1 as counter 
	ldi temp,HIGH(15625)
	out OCR1AH, temp
	ldi temp,LOW(15625)			;1 sec = 15625 with prescaler 256
	out OCR1AL,temp
	
	ldi temp,(1<<OCIE1A)
	out TIMSK,temp				;Output compare A interrupt enable

	ldi temp,  (1<<WGM12) | (1<<CS12) | (0<<CS11) | (0<<CS10) ;Prescaler=256, CTC mode
	out TCCR1B, temp

	ldi temp, 0
	out TCNT1H,temp				;Put timer to zero value
	out TCNT1L,temp
			

	sei										; enable interrupts


FIRSTWAY:

;Check if 1sec passed, since the interrupt will have disabled the CS12 bit in that case
	in temp,TCCR1B
	sbrc temp,CS12
	rjmp FIRSTWAY
	cli
	
	com XL				;Number of pulses in 1 second, low byte
	out PORTA, XL

	rcall SWITCH7

	com XH				;Number of pulses in 1 second, high byte
	out PORTA,XH

	rcall SWITCH7

	

;Check if 4 samples have been taken
	ldi temp,(1<<INT0)	;External interrupt 0 enable
	out GICR,temp


	ldi XL,0			;Set number of pulses to 0 again
	ldi XH,0

	ldi temp,  (0<<WGM12) | (1<<CS12) | (0<<CS11) | (0<<CS10) ;prescaler=256, normal mode
	out TCCR1B, temp

	ldi temp, 0				;Put timer to zero value
	out TCNT1H,temp
	out TCNT1L,temp
	
	sei						;Enable interrupts

SECONDWAY:
	cpi XL,4				;Check until 4 pulses have been counted
	brlo SECONDWAY
	cli
	
	ldi temp,  (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10)			;Disable timer 1, since it is not needed any more
	out TCCR1B, temp
	ldi temp, (0<<INT0)													;Disable external interrupt 0, since it is not needed any more
	out GICR,temp
	
	
	in duration, TCNT1L		;Low byte of timer
	com duration
	out PORTA,duration

	
	rcall SWITCH7

	in duration, TCNT1H		;High byte of timer
	com duration
	out PORTA,duration



RESTART:
	sbic PINC,0			;Press Switch 0 to increase duty cycle by 20%.
	rjmp INCREASE_DC
	sbic PINC,1			;Press Switch 1 to decrease duty cycle by 20%.
	rjmp DECREASE_DC
	rjmp RESTART

INCREASE_DC:
	subi dc, -51		;Increase by 51 = 0,2 * 255
	rjmp END

DECREASE_DC:
	subi dc,51			;Decrease by 51 = 0,2 * 255

END:
	out OCR0,dc			;Write the new duty cycle
	rcall DEBOUNCE
	rjmp REPEAT			
		
;External Interrupt 0, counting number of pulses
EXT_INT0_ISR:

	push temp
	in temp, SREG 							; save SREG in stack
	push temp

	adiw X,1					;Increment X by 1, in order to count the pulses in 1 sec.

	pop temp
	out SREG, temp
	pop temp
	reti


;Output compare interrupt, counting when 1 sec has passed
TIMER_COMPA_ISR:
	
	push temp
	in temp, SREG 							; save SREG in stack
	push temp
	
	
	ldi temp,  (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10)
	out TCCR1B, temp
	ldi temp, (0<<INT0)				;Disable timer 1, external interrupt 0 and output compare interrupt, after 1 sec has passed
	out GICR,temp
	ldi temp, (0<<OCIE1A)
	out TIMSK, temp
	
	pop temp
	out SREG, temp
	pop temp
	reti

SWITCH7:			;Routine that waits for switch 7 to be pressed, in order to show the next value
	sbic PINC,7
	rjmp SWITCH7
	rcall DEBOUNCE
	ret

DEBOUNCE:			;The debounce routine is a 1 sec delay
    ldi  r20, 21
    ldi  r21, 75
    ldi  r22, 191
L1: dec  r22
    brne L1
    dec  r21
    brne L1
    dec  r20
    brne L1
    nop
	ret






