# Nh?p s? nguyên d??ng N t? bàn phím, in ra màn hình các s? chia h?t cho 3 ho?c cho 5 nh? h?n N. 

.text
	li $v0, 5
 	syscall 
	
	addi $v1, $v0, 0	#gán giá tr? $v0 cho $v1 
	li $s0, 2	# gia tri ban ??u i = 2
	li $s1, 3	# $s1 = 3
	li $s2, 5	# $s2 = 5
	
loop: 
	add $s0,$s0,1  #i += 1
	bge $s0, $v1, endloop	#neu i >= $v1 thi endloop
	div $s0, $s1			# $s0/3
	mfhi $t1				# l?y ph?n d? l?u vào $t1
	beq $t1, 0, chiahet		#n?u d? 1 thì chia h?t nh?y sang chiahet
	div $s0, $s2			#$s0 / 5
	mfhi $t2				#l?u ph?n d? vào $t2
	beq $t2, 0, chiahet		#n?u d? 1 thì chia h?t nh?y sang chiahet
	j loop					#vòng l?p
	
chiahet: 
	li 	$v0, 1			
	add $a0, $s0, $zero	#in giá tr? $s0 chia hêt cho 3 ho?c 5
	syscall
	li $v0, 11
 	li $a0, ' '			#in kí t? cách
 	syscall 
	j	loop			#l?p l?i loop 
	
endloop: