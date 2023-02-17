
.data
infix: .space 256
postfix: .space 256
stack: .space 256
prompt:	.asciiz "Enter String contain infix expression\n(note) Input expression has number must be integer and positive number:"
newLine: .asciiz "\n"
prompt_postfix: .asciiz "Postfix is: "
prompt_result: .asciiz "Result is: "
prompt_infix: .asciiz "Infix is: "

# get infix
.text
 li $v0, 54
 la $a0, prompt
 la $a1, infix
 la $a2, 256
 syscall 
 
 
la $a0, prompt_infix
li $v0, 4
syscall
	
la $a0, infix
li $v0, 4
syscall

# convert to postfix

li $s6, -1 # counter
li $s7, -1 # Scounter
li $t7, -1 # Pcounter
while:
        la $s1, infix  #buffer = $s1
        la $t5, postfix #postfix = $t5
        la $t6, stack #stack = $t6
        li $s2, '+'
        li $s3, '-'
        li $s4, '*'
        li $s5, '/'
	addi $s6, $s6, 1  # counter ++ s6 = s6
	
	# get buffer[counter]
	add $s1, $s1, $s6
	lb $t1, 0($s1)	# t1 = value of buffer[counter]
	
		
	
	beq $t1, $s2, operator # '+'
	nop
	beq $t1, $s3, operator # '-'
	nop
	beq $t1, $s4, operator # '*'
	nop
	beq $t1, $s5, operator # '/'
	nop
	beq $t1, 10, n_operator # '\n'
	nop
	beq $t1, 32, n_operator # ' '
	nop
	beq $t1, $zero, endWhile
	nop
	
	# push number to postfix( ??y s? ??n h?u
	addi $t7, $t7, 1
	add $t5, $t5, $t7
	
	sb $t1, 0($t5)
	

	lb $a0, 1($s1)

	
	jal check_number
	beq $v0, 1, n_operator
	nop
	
	add_space:
	add $t1, $zero, 32
	sb $t1, 1($t5)
	addi $t7, $t7, 1
	
	j n_operator
	nop
	
	operator:
	# add to stack ...
		
	beq $s7, -1, pushToStack
	nop
	
	add $t6, $t6, $s7
	lb $t2, 0($t6) # t2 = value of stack[counter]
	
	# check t1 precedence
	beq $t1, $s2, t1to1
	nop
	beq $t1, $s3, t1to1
	nop
	
	li $t3, 2
	
	j check_t2
	nop
		
t1to1:
	li $t3, 1
	
	# check t2 precedence
check_t2:
	
	beq $t2, $s2, t2to1
	nop
	beq $t2, $s3, t2to1
	nop
	
	li $t4, 2	
	
	j compare_precedence
	nop
	
	
t2to1:
	li $t4, 1	
	
compare_precedence:
	
	
	beq $t3, $t4, equal_precedence
	nop
	slt $s1, $t3, $t4
	beqz $s1, t3_large_t4
	nop
################	
# t3 < t4
# pop t2 from stack  and t2 ==> postfix  
# get new top stack do again

	sb $zero, 0($t6)
	addi $s7, $s7, -1  # scounter ++
	addi $t6, $t6, -1
	la $t5, postfix #postfix = $t5
	addi $t7, $t7, 1
	add $t5, $t5, $t7
	sb $t2, 0($t5)
	
	#addi $s7, $s7, -1  # scounter = scounter - 1
	j operator
	nop
	
################	
t3_large_t4:
# push t1 to stack
	j pushToStack
	nop
################
equal_precedence:
# pop t2  from stack  and t2 ==> postfix  
# push to stack

	sb $zero, 0($t6)
	addi $s7, $s7, -1  # scounter ++
	addi $t6, $t6, -1
	la $t5, postfix #postfix = $t5
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
	sb $t1, 0($t6)	
	
	n_operator:	
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
	addi $s7, $s7, -2
	add $t6, $t6, $s7
	
	sb $t2, 0($t5)
	add $t5, $t5, 1
	
	
	j popallstack
	nop

endPostfix:
############################################################################### END POSTFIX
# print postfix
la $a0, prompt_postfix
li $v0, 4
syscall

la $a0, postfix
li $v0, 4
syscall

la $a0, newLine
li $v0, 4
syscall

li $s3, 0 # counter
la $s2, stack #stack = $s2

	
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

	