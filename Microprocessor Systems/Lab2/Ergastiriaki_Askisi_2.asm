.include "m16def.inc"

.def temp=r16
.def temp0=r17
.def tempall=r18
.def code=r23
.def err=r20
.def savedcode=r19

.cseg
.org  0x0000	rjmp RESET

.org OVF1addr	rjmp ISR_OVF	;Timer 1 overflow interrupt vector.

.org INT_VECTORS_SIZE	;Start storing the program after the interrupt handlers.

RESET:
	ser temp
	out DDRB,temp	;Port B as output, port D as input.
	clr temp
	out DDRD,temp
	
	
	ldi temp,1<<TOIE1
	out TIMSK,temp		;Enable timer overflow interrupt, by setting the appropriate  interrupt mask bit to HIGH.
	
	ldi temp,LOW(RAMEND)
	out SPL,temp
	ldi temp,HIGH(RAMEND)	;Initialize stack pointer, at the end of RAM.
	out SPH,temp


START:
	in savedcode,PIND	;Read the code we'd like to save (something like a "setup mode").

	mov temp,savedcode
	andi temp,0b0110_0001	;Error when entering wrong code. Cannot press switch 0, switch 5 or switch 6.
	cpi temp,0b0110_0001	;The other switches can be pressed. Our mask achieves just that.
	brne START				
	
	sbic PIND,PIND7			;In fact, switch 7 needs to be pressed in order to save the code.
	rjmp START

	ori savedcode,0b1110_0001	;Set bit 7 of the pressed code to 1, since it is not actually part of the code.

	cpi savedcode,0b1111_1111	;Check if no button has been pressed yet.
	breq START
	
	
INIT:
	ldi temp,0b1111_1110	;LED0
	out PORTB,temp
	
	rcall DEBOUNCE

	ldi temp,(1<<CS12 | 1<<CS10)	;Prescaler = 1024
	out TCCR1B,temp					;Timer, at 4MHZ, 5s = 19530,25.
	
	
READ:
	in code,PIND	;Simultaneous press. The code that we want to input.
	
	mov temp,savedcode
	and temp,code		;Error when entering wrong code.First, check that bits 0,5,6 or 7 are not pressed, by doing a logical AND
	cp temp,savedcode	;between the saved code and the code we just read. Then, if that is not the case, there is an error.
	brne ERROR_INIT

	cp code,savedcode	;If the codes are equal, we enter normal operation of the system.
	breq NORMALOP_INIT
	
	in XL,TCNT1L	;We read the values in this order, so as not to
	in XH,TCNT1H	;potentially lose information.
	

	cpi XH,HIGH(19530)	;19530 = 0b0100110001001010
	brne READ			;Check timer1 HIGH byte, in case 5s have passed.


	cpi XL,LOW(19530)	;Check timer1 LOW byte, in case 5s have passed.
	brlo READ
	

ERROR_INIT:

	rcall DEBOUNCE	;Switches debounce routine.

	ldi temp0,0b1111_1111		;For blinking led0.
	ldi tempall,0b1111_1111		;For blinking all the leds.

	ldi temp,1<<CS12	;Prescaler = 256
	out TCCR1B,temp		;Timer, at 4MHZ, 1s = 15624, so for an overflow, 65535-15624=49911. We want to capture an overflow interrupt every 1s.
	ldi temp,HIGH(49911)
	out TCNT1H,temp
	ldi temp,LOW(49911)
	out TCNT1L,temp
		
	clr err
	sei		;Enable global interrupts.	
	
ERROR:
	
	in code,PIND	;Simultaneous press. Same as above.
	
	mov temp,savedcode
	and temp,code		;Error when entering wrong code, same as above.
	cp temp,savedcode
	brne ERROR_INIT_2


	cp code,savedcode	;Enter normal operation, same as above.
	breq NORMALOP_INIT
	rjmp ERROR

ERROR_INIT_2:
	ser err				;Set the error flag, if there is a second error after the first.
	rjmp ERROR


ISR_OVF:
	sbrs err,0			;Timer1 overflow interrupt service routine. Call the corresponding subroutine to blink either led0 or all leds.
	rcall LED0_BLINK
	sbrc err,0
	rcall ALL_LED_BLINK
	reti

LED0_BLINK:				;Subroutine for blinking led0 every 1s.
	out PORTB,temp0
	com temp0
	ori temp0,0b1111_1110
	push temp
	ldi temp,HIGH(49911)	;Reset timer1.
	out TCNT1H,temp
	ldi temp,LOW(49911)
	out TCNT1L,temp
	pop temp
	ret

ALL_LED_BLINK:		;Subroutine for blinking all leds every 1s.
	push temp		;Save the value of temp since it is used inside the interrupt.
	in temp,SREG	;We save SREG in this register, in case the interrupt is called just between lines 110 and 111 (cp and breq). After all, the command "com tempall" below modifies the Z flag.
	push temp		;Save the value of SREG.
	out PORTB,tempall
	com tempall
	ldi temp,HIGH(49911)	;Reset timer1.
	out TCNT1H,temp
	ldi temp,LOW(49911)
	out TCNT1L,temp
	pop temp
	out SREG,temp 	;Use the status of SREG BEFORE we entered the interrupt.
	pop temp
	ret

DEBOUNCE:
	in temp,PIND
	cpi temp,0b1111_1111
	brne DEBOUNCE
	ret


NORMALOP_INIT:
	rcall DEBOUNCE

NORMALOP:
	cli			;Disable global interrupts.
	ldi temp,0b1111_1101	;Led1.
	out PORTB,temp
	
	sbis PIND,PIND0	;Restarts normal operation.
	rjmp NORMALOP


SWITCH1:	
	sbis PIND,PIND1	;If pin1 is pressed, there is no chance for a violation on pin2.
	rjmp OTHERPINS
	
	ldi temp,0b1111_0011
	sbis PIND,PIND2	
	out PORTB,temp		;Pin2 error.
	sbis PIND,PIND2
	rjmp LOOP	

OTHERPINS:
	sbis PIND,PIND3	;If pin3 is pressed, there is no chance for a violation on pins 4 to 7.
	rjmp NORMALOP

	ldi temp,0b0111_1011
	sbis PIND,PIND7
	out PORTB,temp		;Pin7 violation.
	sbis PIND,PIND7
	rjmp LOOP
	
	ldi temp,0b1011_1011
	sbis PIND,PIND6
	out PORTB,temp		;Pin6 violation.
	sbis PIND,PIND6
	rjmp LOOP

	ldi temp,0b1101_1011
	sbis PIND,PIND5
	out PORTB,temp		;Pin5 violation.
	sbis PIND,PIND5
	rjmp LOOP

	ldi temp,0b1110_1011
	sbis PIND,PIND4
	out PORTB,temp		;Pin4 violation.
	sbic PIND,PIND4
	rjmp NORMALOP


LOOP:
	sbic PIND,PIND0		;If there is a violation, loop until pin0 is pressed. In that case, normal operation is restarted.
	rjmp LOOP
	rjmp NORMALOP

