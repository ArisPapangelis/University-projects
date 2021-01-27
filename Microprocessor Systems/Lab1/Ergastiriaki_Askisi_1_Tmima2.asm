;Comments are in Greek, install the appropriate fonts to view them.

;ΤΜΗΜΑ ΙΙ

;Αρης Ελευθεριος Παπαγγελης - ΑΕΜ 8883
;Στεφανος Παπαδαμ - ΑΕΜ 8885
;Εργαστηριακο Group 2

.include "m16def.inc"

.dseg

.def a3=r0
.def a2=r1
.def a1=r2
.def a0=r3
.def b3=r4
.def b2=r5
.def b1=r6
.def b0=r7
.def temp=r16
.def temp2=r17
.def low3=r8
.def low2=r9
.def low1=r10
.def low0=r11
.def high3=r12
.def high2=r13
.def high1=r14
.def high0=r15
.def sw=r22
.def eo1=r23
.def eo2=r24



.cseg
;Αποθηκευουμε τα ΑΕΜ στη μνημη προγραμματος.
AEM: .DB "8883","8885"

;Χρησιμοποιουμε το PORT D ως εισοδο και PORT B ως εξοδο.
	ser temp2
	out DDRB,temp2
	clr temp2
	out DDRD,temp2



;Φορτώνουμε τη διευθυνση του πρωτου ψηφιου στον Z, και απο εκει αποθηκευουμε το καθε ψηφιο σε καταχωρητη.
	ldi ZL,LOW(AEM*2)
	ldi ZH,HIGH(AEM*2)

	lpm a3,Z+
	lpm a2,Z+
	lpm a1,Z+
	lpm a0,Z+
	lpm b3,Z+
	lpm b2,Z+
	lpm b1,Z+
	lpm b0,Z+




;Συγκρινουμε τα ψηφια, ακομα και κατα ASCII, για να δουμε τον μεγαλυτερο απο τους 2 αριθμους.
	cp a3,b3
	brlo IF
	cp b3,a3
	brlo ELSE

	cp a2,b2
	brlo IF
	cp b2,a2
	brlo ELSE

	cp a1,b1
	brlo IF
	cp b1,a1
	brlo ELSE

	cp a0,b0
	brlo IF

	;Φορτωνουμε το μικροτερο και το μεγαλυτερο ΑΕΜ στους καταλληλους καταχωρητες.
ELSE:
	mov low3,b3
	mov low2,b2
	mov low1,b1
	mov low0,b0
	mov high3,a3
	mov high2,a2
	mov high1,a1
	mov high0,a0

	rjmp NEXT

IF:
	mov low3,a3
	mov low2,a2
	mov low1,a1
	mov low0,a0
	mov high3,b3
	mov high2,b2
	mov high1,b1
	mov high0,b0



;Διαβαζουμε το PIND και το αποθηκευουμε στον καταχωρητη που ονομασαμε sw. Υστερα, κανουμε branch αν πατηθηκε ενα απο τα αποδεκτα πληκτρα, αλλιως επαναλαμβανουμε
;μεχρι να διαβαστει αποδεκτο πληκτρο.
NEXT:
	in sw,PIND
	cpi sw,0b11110111
	breq WAIT3

	cpi sw,0b11111011
	breq WAIT2

	cpi sw,0b11111101
	breq WAIT1

	cpi sw,0b11111110
	breq WAIT0

	cpi sw,0b01111111
	breq WAIT7

	rjmp NEXT


;Τα ακολουθα waits εχουν το εξης νοημα: Περιμενουμε μεχρι το πληκτρο να απελευθερωθει, δηλαδη να επανελθει στην αρχικη του κατασταση, ωστε να εκτελεσουμε τις 
;ενεργειες που προσδιοριζει το καθε πληκτρο.
WAIT3:
	in sw,PIND
	cpi sw,0xFF
	breq SW3
	rjmp WAIT3

WAIT2:
	in sw,PIND
	cpi sw,0xFF
	breq SW2
	rjmp WAIT2

WAIT1:
	in sw,PIND
	cpi sw,0xFF
	breq SW1
	rjmp WAIT1

WAIT0:
	in sw,PIND
	cpi sw,0xFF
	breq SW0
	rjmp WAIT0

WAIT7:
	in sw,PIND
	cpi sw,0xFF
	breq SW7
	rjmp WAIT7






SW3:
	mov temp,low3
	subi temp,48
	lsl temp
	lsl temp
	lsl temp
	lsl temp

	mov temp2,low2	;2 πρωτα ψηφια μικροτερου ΑΕΜ
	subi temp2,48

	add temp,temp2
	com temp
	out PORTB,temp

	rjmp DELAY

SW2:
	mov temp,low1
	subi temp,48
	lsl temp
	lsl temp
	lsl temp
	lsl temp

	mov temp2,low0	;2 τελευταια ψηφια μικροτερου ΑΕΜ
	subi temp2,48

	add temp,temp2
	com temp
	out PORTB,temp

	rjmp DELAY

SW1:
	mov temp,high3
	subi temp,48
	lsl temp
	lsl temp
	lsl temp
	lsl temp

	mov temp2,high2	;2 πρωτα ψηφια μεγαλυτερου ΑΕΜ
	subi temp2,48

	add temp,temp2
	com temp
	out PORTB,temp

	rjmp DELAY

SW0:
	mov temp,high1
	subi temp,48
	lsl temp
	lsl temp
	lsl temp
	lsl temp

	mov temp2,high0	;2 τελευταια ψηφια μεγαλυτερου ΑΕΜ
	subi temp2,48

	add temp,temp2
	com temp
	out PORTB,temp



;Καθυστερηση 10 δευτερολεπτων για τα πληκτρα 3,2,1 και 0, οπως ζητειται στην εκφωνηση της ασκησης.
DELAY:

; Delay 40 000 000 cycles
; 10s at 4.0 MHz

    ldi  r18, 203
    ldi  r19, 236
    ldi  r20, 133
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    nop


	ser temp2
	out PORTB,temp2		;Κανουμε reset το PORTB μολις παρελθουν τα 10 δευτερολεπτα, και ξαναεπιστρεφουμε στο σταδιο που ελεγχουμε πιο πληκτρο πατηθηκε.
	rjmp NEXT




SW7:

;Μπορουμε να κανουμε μια τροποποιηση εδω.

;Αν περριτος, τοτε το LSB θα ειναι παντα 1, ενω αν αρτιος, θα ειναι παντα 0.
;Επομενως, αν περιττος, το andi θα βγει 1, αλλιως αν αρτιος θα βγει 0, με βαση τη μασκα που χρησιμοποιουμε.
	mov eo1,low0
	subi eo1,48
	andi eo1,0b00000001 ;Μικροτερο

	mov eo2,high0
	subi eo2,48
	andi eo2,0b00000001 ;Μεγαλυτερο

	cp eo1,eo2
	brlo IF1

	breq IF2	

	cp eo2,eo1
	brlo IF3

	


IF1:
	ldi eo1,0b11111100		;Μικροτερος αρτιος, μεγαλυτερος περιττος.
	out PORTB,eo1
	rjmp END

IF3:
	ldi eo1,0b11111111		;Μεγαλυτερος αρτιος, μικροτερος περιττος.
	out PORTB,eo1	
	rjmp END

IF2:
	cpi eo1,0
	breq IF22			

	ldi eo1,0b11111101	;Και οι 2 περιττοι.
	out PORTB,eo1
	rjmp END

IF22:
	ldi eo1,0b11111110	;Και οι 2 αρτιοι.		
	out PORTB,eo1



END:
	rjmp END
	nop


