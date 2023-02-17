
.data
trung_to: .space 256
hau_to: .space 256
stack: .space 256
string:	.asciiz "nhap chuoi bieu thuc trung to: "
newLine: .asciiz "\n"
string_hau_to: .asciiz "Bieu thuc hau to: "
ket_qua: .asciiz "ket qua: "


# get trung_to
.text

 
li $v0, 4
la $a0,string
syscall

li $v0, 8
la $a0 , trung_to
li $a1,256
syscall 

# convert to hau_to

li $s6, -1 # counter
li $s7, -1 # Scounter
li $t7, -1 # Pcounter
while:
        la $s1, trung_to  #buffer = $s1
        la $t5, hau_to #hau_to = $t5
        la $t6, stack #stack = $t6
        li $s2, '+'
        li $s3, '-'
        li $s4, '*'
        li $s5, '/'
        li $a3, '&'
	addi $s6, $s6, 1  # counter ++ s6 = s6
	
	# get buffer[counter]
	add $s1, $s1, $s6
	lb $t1, 0($s1)	# t1 = value of buffer[counter]
	
		
	beq $t1,'&',toan_tu # 'and'
	nop
	beq $t1, $s2, toan_tu # '+'
	nop
	beq $t1, $s3, toan_tu # '-'
	nop
	beq $t1, $s4, toan_tu # '*'
	nop
	beq $t1, $s5, toan_tu # '/'
	nop
	beq $t1, 10, n_toan_tu # '\n'
	nop
	beq $t1, 32, n_toan_tu # ' '
	nop
	beq $t1, $zero, endWhile
	nop
	
	# push number to hau_to( ??y s? ??n h?u
	addi $t7, $t7, 1 # t7 ++
	add $t5, $t5, $t7
	
	sb $t1, 0($t5)#doc t1 neu là toan hang vao hau to 
	

	lb $a0, 1($s1)# doc ky tu tiep theo trong trung to vao a0

	
	jal check_number # kiem tra ky tu do co phai la 1 so hay khong
	beq $v0, 1, n_toan_tu # v0 la gia tri tra ve neu v0 = 1 thi no là 1 so con v0 = 0 thi no la toan tu
	nop
	
	add_space: # them khoang cach vao bieu thuc hau to
	add $t1, $zero, 32 
	sb $t1, 1($t5)
	addi $t7, $t7, 1

	j n_toan_tu
	nop
	
	toan_tu:
	# add to stack ...
		
	beq $s7, -1, pushToStack # toan tu dau tien vao stack
	nop
	
	add $t6, $t6, $s7
	lb $t2, 0($t6) # t2 = value of stack[counter]
	
	# check t1 precedence
	beq $t1,'&',t0to1
	nop
	beq $t1, $s2, t1to1
	nop
	beq $t1, $s3, t1to1
	nop
	
	li $t3, 2
	
	j check_t2
	nop
t0to1:
li  $t3	,4
j check_t2
nop
t1to1:
li $t3, 1
j check_t2	
nop
	# check t2 precedence
check_t2:
	beq $t2,'&',t0to2
	nop
	beq $t2, $s2, t2to1
	nop
	beq $t2, $s3, t2to1
	nop
	
	li $t4, 2	
	
	j compare_precedence
	nop
	
t0to2:
	li $t4,4
	j compare_precedence
	nop
t2to1:
	li $t4, 1	
	j compare_precedence
	nop
compare_precedence:
	
	
	beq $t3, $t4, equal_precedence
	nop
	slt $s1, $t3, $t4
	beqz $s1, t3_large_t4
	nop
################	
# t3 < t4
# pop t2 from stack  and t2 ==> hau_to  
# get new top stack do again

	sb $zero, 0($t6)
	addi $s7, $s7, -1  # scounter ++
	addi $t6, $t6, -1
	la $t5, hau_to #hau_to = $t5
	addi $t7, $t7, 1
	add $t5, $t5, $t7
	sb $t2, 0($t5)
	
	#addi $s7, $s7, -1  # scounter = scounter - 1
	j toan_tu
	nop
	
################	
t3_large_t4:
# push t1 to stack
	j pushToStack
	nop
################
equal_precedence:
# pop t2  from stack  and t2 ==> hau_to  
# push to stack

	sb $zero, 0($t6)
	addi $s7, $s7, -1  # scounter ++
	addi $t6, $t6, -1
	la $t5, hau_to #hau_to = $t5
	addi $t7, $t7, 1 # pcounter ++
	add $t5, $t5, $t7
	
	sb $t2, 0($t5)
	j pushToStack
	nop
################
pushToStack:

	la $t6, stack #stack = $t6
	addi $s7, $s7, 1  # scounter ++
	add $t6, $t6, $s7
	sb $t1, 0($t6)	# them t1 vao stack 
	
	n_toan_tu:	
	j while	
	nop
	
#######################
endWhile:
	
	addi $s1, $zero, 32
	add $t7, $t7, 1
	add $t5, $t5, $t7 
	la $t6, stack
	add $t6, $t6, $s7
	
popallstack:

	lb $t2, 0($t6) # t2 = value of stack[counter]
	beq $t2, 0, endPostfix
	sb $zero, 0($t6)
	#addi $s7, $s7,-3
	#add $t6, $t6, $s7
	add $t6, $t6, -1
	sb $t2, 0($t5)
	add $t5, $t5, 1
	
	j popallstack
	nop

endPostfix:
# print hau_to
la $a0, string_hau_to
li $v0, 4
syscall

la $a0, hau_to
li $v0, 4
syscall

la $a0, newLine
li $v0, 4
syscall


############################################################################### Caculate

li $s3, 0 # counter
la $s2, stack #stack = $s2


# hau_to to stack
while_p_s:
	la $s1, hau_to #hau_to = $s1
	
	add $s1, $s1, $s3
	lb $t1, 0($s1) # load byte vào thanh ghi t1
	
	
	# if null
	beqz $t1 end_while_p_s # neu t1 bang 0 thì end
	nop
	

	add $a0, $zero, $t1 # a0 = t1
	jal check_number    # kiêm tra xem do co phai la toan tu hay so
	nop
	
	beqz $v0, is_toan_tu # neu V0 = 0 thi la mot toan tu va nhay den opertor
	nop
	
	jal add_number_to_stack # them so vao stack
	nop
	
	j continue
	nop
	
	
	is_toan_tu:
	
	jal pop # nhay den pop
	nop
	
	add $a1, $zero, $v0 # b
	
	jal pop
	nop
	
	add $a0, $zero, $v0 # a
		
	add $a2, $zero, $t1 # luu toan tu
	
	jal caculate
		
	
	continue:
	
	add $s3, $s3, 1 # counter++
	j while_p_s
	nop



caculate:
	sw $ra, 0($sp)# load dia chi tra ve vao sp is_toantu
	li $v0, 0
	beq $t1, '*', cal_case_mul
	nop
	beq $t1, '/', cal_case_div
	nop
	beq $t1, '+', cal_case_plus
	nop
	beq $t1, '-', cal_case_sub
	nop 
	beq $t1,'&', cal_case_and
	
	cal_case_and:
		and $v0,$a0,$a1
		j cal_push
		
	cal_case_mul:
		mul $v0, $a0, $a1
		j cal_push
	cal_case_div:
		div $a0, $a1
		mflo $v0
		j cal_push
	cal_case_plus:
		add $v0, $a0, $a1
		j cal_push
	cal_case_sub:
		sub $v0, $a0, $a1
		j cal_push	
	cal_push:
		add $a0, $v0, $zero
		jal push
		nop
		lw $ra, 0($sp) # qua ve is_toantu
		jr $ra
		nop
	


add_number_to_stack:
	# save $ra
	sw $ra, 0($sp)# l?u dia chi cha ve vao thanh ghi sp trong vong while_p_a
	li $v0, 0
	
	while_ants:
		beq $t1, '0', ants_case_0
		nop
		beq $t1, '1', ants_case_1
		nop
		beq $t1, '2', ants_case_2
		nop
		beq $t1, '3', ants_case_3
		nop
		beq $t1, '4', ants_case_4
		nop
		beq $t1, '5', ants_case_5
		nop
		beq $t1, '6', ants_case_6
		nop
		beq $t1, '7', ants_case_7
		nop
		beq $t1, '8', ants_case_8
		nop
		beq $t1, '9', ants_case_9
		nop
		
		ants_case_0:
			j ants_end_sw_c
		ants_case_1:
			addi $v0, $v0, 1	
			j ants_end_sw_c
			nop
		ants_case_2:
			addi $v0, $v0, 2
			j ants_end_sw_c
			nop
		ants_case_3:
			addi $v0, $v0, 3
			j ants_end_sw_c
			nop
		ants_case_4:
			addi $v0, $v0, 4
			j ants_end_sw_c
			nop
		ants_case_5:
			addi $v0, $v0, 5
			j ants_end_sw_c
			nop
		ants_case_6:
			addi $v0, $v0, 6
			j ants_end_sw_c
			nop
		ants_case_7:
			addi $v0, $v0, 7
			j ants_end_sw_c
			nop
		ants_case_8:
			addi $v0, $v0, 8
			j ants_end_sw_c
			nop
		ants_case_9:
			addi $v0, $v0, 9
			j ants_end_sw_c
			nop
		ants_end_sw_c:
			
			add $s3, $s3, 1 # counter++
			la $s1, hau_to #hau_to = $s1
	
			add $s1, $s1, $s3
			lb $t1, 0($s1)
		
			beq $t1, $zero, end_while_ants
			beq $t1, ' ', end_while_ants
			
			mul $v0, $v0, 10 #v0 = 10*v0
			
			j while_ants
		
	end_while_ants:
		add $a0, $zero, $v0# a0 = v0
		jal push
		# get $ra
		lw $ra, 0($sp) #load dia chi ra tu thanh ghi sp
		jr $ra
		nop
		
		

check_number:
        
	li $t8, '0'
	li $t9, '9'
	
	beq $t8, $a0, check_number_true
	beq $t9, $a0, check_number_true
	
	slt $v0, $t8, $a0
	beqz $v0, check_number_false
	
	slt $v0, $a0, $t9
	beqz $v0, check_number_false
	
	
	check_number_true:
	
	li $v0, 1
	jr $ra
	nop
	check_number_false:
	
	li $v0, 0
	
	jr $ra
	nop



pop:
	lw $v0, -4($s2)#doc ra v0
	sw $zero, -4($s2)# xoa ô day 
	add $s2, $s2, -4 #  ??a v? vi tri ?ó
	jr $ra
	nop

push:
	sw $a0, 0($s2)
	add $s2, $s2, 4 #s2= s2+4 t?ng ??a ch? lên 4
	jr $ra
	nop
	

end_while_p_s:

# add null to end of stack


# print hau_to
la $a0, ket_qua
li $v0, 4
syscall


jal pop
add $a0, $zero, $v0 
li $v0, 1
syscall

la $a0, newLine
li $v0, 4
syscall
