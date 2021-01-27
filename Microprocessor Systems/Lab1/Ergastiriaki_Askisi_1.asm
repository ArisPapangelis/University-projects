;Comments are in Greek, install the appropriate fonts to view them.

;ΤΜΗΜΑ Ι

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
.def eo1=r18
.def eo2=r19
.def high0=r10
.def low0=r11




.cseg
;Αποθηκευουμε τα ΑΕΜ στη μνημη προγραμματος.
AEM: .DB "8883","8885"

;Χρησιμοποιουμε το PORT B ως εξοδο.
	ser temp
	out DDRB,temp


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



;Επεξεργαζομαστε καταλληλα το 3ο και το 4ο ψηφιο του μικροτερου αεμ, ωστε να το εμφανισουμε στα LED.
ELSE:
	mov temp,b1
	subi temp,48
	lsl temp
	lsl temp	;Κανουμε 4 ολισθησεις αριστερα, για να απομονωσουμε το 3ο ψηφιο στα led 7-4
	lsl temp
	lsl temp

	mov temp2,b0
	subi temp2,48

	add temp,temp2
	com temp		;Προσθετουμε τα ψηφια, και αντιστρεφουμε τα bits λογω της αρνητικης λογικης.
	out PORTB,temp

	mov low0,b0
	mov high0,a0

	rjmp NEXT1

IF:
	mov temp,a1
	subi temp,48
	lsl temp
	lsl temp
	lsl temp
	lsl temp

	mov temp2,a0
	subi temp2,48

	add temp,temp2
	com temp
	out PORTB,temp

	mov low0,a0
	mov high0,b0


NEXT1:
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
	ldi eo1,0b11111100
	;and eo1,temp		;Μικροτερος αρτιος, μεγαλυτερος περιττος.
	out PORTB,eo1
	rjmp END

IF3:
	ldi eo1,0b11111111
	;and eo1,temp		;Μεγαλυτερος αρτιος, μικροτερος περιττος.
	out PORTB,eo1	
	rjmp END

IF2:
	cpi eo1,0
	breq IF22			

	ldi eo1,0b11111101
	;and eo1,temp		;Και οι 2 περιττοι.
	out PORTB,eo1
	rjmp END

IF22:
	ldi eo1,0b11111110	;Και οι 2 αρτιοι.
	;and eo1,temp		
	out PORTB,eo1

END:
	nop




