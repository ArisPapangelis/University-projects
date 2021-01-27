.data 0x10000000
	#Καθε συμβολοσειρα θα ειναι 8 byte, αφου θα εχει 7 χαρακτηρες + τον χαρακτηρα NULL.
	#Για αυτο πιο κατω ξεκιναμε να αποθηκευουμε τους αριθμους απο τη διευθυνση 0x10000040.
	T1: .asciiz "a(1,1)="
	T2: .asciiz "a(1,2)="
	T3: .asciiz "a(2,1)="
	T4: .asciiz "a(2,2)="
	T5: .asciiz "b(1,1)="
	T6: .asciiz "b(1,2)="
	T7: .asciiz "b(2,1)="
	T8: .asciiz "b(2,2)="
	.space 96
	T9: .asciiz "c(1,1)="
	T10: .asciiz "c(1,2)="
	T11: .asciiz "c(2,1)="
	T12: .asciiz "c(2,2)="
.text
main:
	
	#Ο ακολουθος επαναλαμβανομενος κωδικας απλα εκτυπωνει τις καταλληλες συμβολοσειρες 
	#και διαβαζει τους απαραιτητους αριθμους.
	
	li $v0,4
	la $a0,T1
	syscall
	li $v0,7
	syscall
	sdc1 $f0,0x10000040
	
	li $v0,4
	la $a0,T2
	syscall
	li $v0,7
	syscall
	sdc1 $f0,0x10000048
	
	li $v0,4
	la $a0,T3
	syscall
	li $v0,7
	syscall
	sdc1 $f0,0x10000050
	
	li $v0,4
	la $a0,T4
	syscall
	li $v0,7
	syscall
	sdc1 $f0,0x10000058
	
	li $v0,4
	la $a0,T5
	syscall
	li $v0,7
	syscall
	sdc1 $f0,0x10000060
	
	li $v0,4
	la $a0,T6
	syscall
	li $v0,7
	syscall
	sdc1 $f0,0x10000068
	
	li $v0,4
	la $a0,T7
	syscall
	li $v0,7
	syscall
	sdc1 $f0,0x10000070
	
	li $v0,4
	la $a0,T8
	syscall
	li $v0,7
	syscall
	sdc1 $f0,0x10000078
	
	#Για ομορφια!
	li $v0,11
	li $a0,10
	syscall
	
	#Αποθηκευουμε τις διευθυνσεις βασεων ωστε να τις περασουμε σαν ορισμα.
	
	la $a0,0x10000040
	la $a1,0x10000060
	la $a2,0x10000080
	
	#Αποθηκευουμε στη στοιβα τους καταχωρητες που θα πρεπει να επαναφερουμε.
	addi $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	
	#Καλουμε τη συναρτηση/διαδικασια
	jal mm
	
	#Επαναφερουμε τους καταχωρητες που αποθηκευσαμε στη στοιβα.
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	addi $sp,$sp,16
	
	#Εκτυπωνουμε τον πινακα C
	li $v0,4
	la $a0,T9
	syscall
	li $v0,3
	ldc1 $f12,0($a2)
	syscall
	li $v0,11
	#Το 9 ειναι ο χαρακτηρας TAB στον πινακα ASCII, τον οποιο και εκτυπωνουμε ωστε να ειναι
	#το αποτελεσμα σε μορφη πινακα.
	li $a0,9
	syscall
	
	li $v0,4
	la $a0,T10
	syscall
	li $v0,3
	ldc1 $f12,8($a2)
	syscall
	li $v0,11
	li $a0,10
	syscall
	
	li $v0,4
	la $a0,T11
	syscall
	li $v0,3
	ldc1 $f12,16($a2)
	syscall
	li $v0,11
	li $a0,9
	syscall
	
	li $v0,4
	la $a0,T12
	syscall
	li $v0,3
	ldc1 $f12,24($a2)
	syscall
	li $v0,11
	li $a0,10
	syscall
	
	jr $ra
	
	
mm:
	li $t3,2
	#Το i
	li $s0,0
	iloop:
	
	#Το j
	li $s1,0
	jloop:
		#Για πινακα C
		sll $t2,$s0,1
		add $t2,$t2,$s1
		sll $t2,$t2,3
		add $t2,$t2,$a2
		ldc1 $f8,0($t2)
		
	#Το k
	li $s2,0
	kloop:
		
		#Για πινακα A
		sll $t0,$s0,1
		add $t0,$t0,$s2
		sll $t0,$t0,3
		add $t0,$t0,$a0
		
		#Για πινακα B
		sll $t1,$s2,1
		add $t1,$t1,$s1
		sll $t1,$t1,3
		add $t1,$t1,$a1
		
		ldc1 $f2,0($t0)
		ldc1 $f4,0($t1)
		mul.d $f6,$f2,$f4
		add.d $f8,$f8,$f6
		
		addi $s2,$s2,1
		bne $s2,$t3,kloop
		
		sdc1 $f8,0($t2)
		addi $s1,$s1,1
		bne $s1,$t3,jloop
		
		addi $s0,$s0,1
		bne $s0,$t3,iloop
		
		jr $ra
		
		
		
		
		
		
		
		
		
		
		
		
	