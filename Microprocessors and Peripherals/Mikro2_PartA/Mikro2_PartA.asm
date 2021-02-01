;AVR running at 4 MHz.

.include "m16def.inc"

.def temp=r16
.def duration=r17

.org 0x0000

	rjmp RESET				;Reset vector

.org 0x0002

	rjmp EXT_INT0_ISR		;External interrupt 0 interrupt vector

.org 0x000C
	
	rjmp TIMER_COMPA_ISR	;Output compare timer 1A interrupt vector


.org 0x0100

RESET:
	ldi XL,0			;Used as count of pulses
	ldi XH,0

	ldi duration,0

	ldi temp, high(RAMEND) 					;Main program start
	out SPH, temp							;Set stack pointer to top of RAM
	ldi temp, low(RAMEND)	
	out SPL, temp

	ldi temp, 0b1111_1011					
	out DDRD, temp							; Set PD5(OC1A) as output, PD2(INT0) as input
	
	
	ser temp
	out DDRB,temp							;Port B as leds
	out PORTB,temp
	
	clr temp
	out DDRC,temp							;Port C as switches
		
	
	ldi temp, (1 << ISC01)	;Falling edge interrupts on external interrupt 0.
	out MCUCR,temp

	ldi temp,(1<<INT0)	;External interrupt 0 enable
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

	ldi temp, 0					;Put timer to zero value
	out TCNT1H,temp
	out TCNT1L,temp
			

	sei										;Enable interrupts


FIRSTWAY:

;Check if 1sec passed, since the interrupt will have disabled the CS12 bit in that case
	in temp,TCCR1B
	sbrc temp,CS12
	rjmp FIRSTWAY
	cli
	
	com XL				;Number of pulses in 1 second, low byte.
	out PORTB, XL

	rcall SWITCH7

	com XH				;Number of pulses in 1 second, high byte.
	out PORTB,XH

	rcall SWITCH7

	

;Check if 4 samples have been taken
	ldi temp,(1<<INT0)	;External interrupt 0 enable
	out GICR,temp

	ldi XL,0			;Set number of pulses to 0 again
	ldi XH,0

	ldi temp,  (0<<WGM12) | (1<<CS12) | (0<<CS11) | (0<<CS10) ;prescaler=256, normal mode
	out TCCR1B, temp

	ldi temp, 0
	out TCNT1H,temp		;Put timer to zero value
	out TCNT1L,temp
	
	sei					;Enable interrupts

SECONDWAY:
	cpi XL,4			;Check until 4 pulses have been counted
	brlo SECONDWAY
	cli
	
	ldi temp,  (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10)		;Disable timer 1, since it is not needed any more
	out TCCR1B, temp
	ldi temp, (0<<INT0)												;Disable external interrupt 0, since it is not needed any more
	out GICR,temp
	
	
	in duration, TCNT1L		;Low byte of timer
	com duration
	out PORTB,duration

	
	rcall SWITCH7

	in duration, TCNT1H		;High byte of timer
	com duration
	out PORTB,duration

	rcall SWITCH7

;A/D calculation

	ldi temp,0			;Port A as input to ADC
	out DDRA,temp
	
	ldi temp, (1<<ADEN) | (1<<ADPS2) | (1<<ADPS0)	;Enable ADC with ck/32
	out ADCSRA,temp	
	
	ldi temp, (1<<REFS0)							;Reference voltage is VCC, which is 5 volt
	out ADMUX,temp

	sbi ADCSRA,ADSC				;Enable start of conversion bit, using pin 0 on port A.
	

CONVERSION:
	sbic ADCSRA,ADSC			;When the ADSC bit goes low, the conversion will have finished
	rjmp CONVERSION

	in temp, ADCL		;First 8 bits of conversion
	com temp
	out PORTB,temp

	rcall SWITCH7

	in temp, ADCH		;Last 2 bits of conversion
	com temp
	out PORTB,temp
	
	sbi ADCSRA,ADIF		;Write a logical one to clear the conversion flag

RESTART:
	sbic PINC,0			;Press Switch 0 to reset program.
	rjmp RESTART

	rcall DEBOUNCE
	rjmp RESET			;Reset program for next potentiometer position.
		

;External Interrupt 0, counting number of pulses
EXT_INT0_ISR:

	push temp
	in temp, SREG 							; save SREG in stack
	push temp

	adiw X,1								;Increment X by 1, in order to count the pulses in 1 sec.

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
	ldi temp, (0<<INT0)													;Disable timer 1, external interrupt 0 and output compare interrupt, after 1 sec has passed
	out GICR,temp
	ldi temp, (0<<OCIE1A)
	out TIMSK, temp
	
	pop temp
	out SREG, temp
	pop temp
	reti

SWITCH7:				;Routine that waits for switch 7 to be pressed, in order to show the next value
	sbic PINC,7
	rjmp SWITCH7				
	rcall DEBOUNCE
	ret

DEBOUNCE:				;The debounce routine is a 1 sec delay
    ldi  r19, 21
    ldi  r20, 75
    ldi  r21, 191
L1: dec  r21
    brne L1
    dec  r20
    brne L1
    dec  r19
    brne L1
    nop
	ret






