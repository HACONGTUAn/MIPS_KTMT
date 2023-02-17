.data
	Mess0 : .asciiz "Nhap so:"
	error : .asciiz "So cua ban bi le chu so khong tinh duoc!"
	error1: .asciiz "so bi am mat roi"
	Mess1: .asciiz "So nay la so may man!"
	Mess2: .asciiz "so nay khong may man"
.text
	li $v0,4 
	li $t9,10 #for div
	li $t8,0 # count_char= 0
	li $t7,0 # sum_all
	li $t6,0 # sum1
	la $a0,Mess0
	syscall
	li $v0,5 # $v0 = x
	syscall
	slt $t0,$v0,$0 # so sanh v0 < 0 khong neu khong thi t0 = 0 co thi t0 = 1
	bne $t0,$zero,err1 # neu t0 khac bang 0 thi nhay den err1
	addi $t1,$v0,0 # y = x
loop:
	beq $t1,$zero,end_loop
	div $t1,$t9#t1/t9
	mflo $t1 # t1 = t1/10
	mfhi $t2 # t2 = char
	add $t7,$t7,$t2# t7 = t7+t2
	addi $t8,$t8,1#t8 = t8+1
	j loop
	# vong lap loop de tinh tong cua so
end_loop:
	li $t9,2
	div $t8,$t9 # check odd t8/t9 de xem do dai phan tu tinh tu 0 den n/2
	mfhi $t9 
	mflo $t0 # get haf t0 = n/2
	bne $t9,$zero,err0 # check odd
	#if not 
	addi $t1,$v0,0 # y = x
	li $t9,10 #for div
loop1:
	beq $t0,$zero,endloop1
	div $t1,$t9
	mflo $t1
	mfhi $t2
	add $t6,$t6,$t2
	subi $t0,$t0,1
	j loop1
endloop1:
	sub $t5,$t7,$t6 # t7 - t6
	beq $t5,$t6,lucky# t5 == t6 thi la so may man
unlucky:
	li $v0,4
	la $a0,Mess2
	syscall
	j endMain
lucky:
	li $v0,4
	la $a0,Mess1
	syscall
	j endMain
err0:
	li $v0,4
	la $a0,error
	syscall
	j endMain
err1:
	li $v0,4
	la $a0,error1
	syscall
endMain:
