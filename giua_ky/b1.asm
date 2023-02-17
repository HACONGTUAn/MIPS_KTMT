.data
A: .space 100
Message1: .asciiz "Nhap so phan tu (<= 25): "
Message2: .asciiz "Nhap phan tu cho mang:  "
Message3: .asciiz "So phan tu trong doan M va N la:  "
Message4: .asciiz "Khong co phan tu nao trong doan M va N\n"
Message5: .asciiz "M = "
Message6: .asciiz "N = "
.text
main:
	la 	$s0, A				# load address of array A
	
	li	$v0, 51
	la	$a0, Message1
	syscall
	
	beq $a1, -1, main
	beq $a1, -3, main
	beq $a1, -2, exit

	add $s1, $zero, $a0		# Length array A do dai mang
	li $s4, 0				# count
	li $t0, 0				# i = 0
input_array:
	bge $t0, $s1, end_input_array
input_element:
	li	$v0, 51
	la	$a0, Message2
	syscall
	
	beq $a1, -1, input_element
	beq $a1, -3, input_element
	beq $a1, -2, exit
	
	add $t1, $t0, $t0		# 2i
	add $t1, $t1, $t1		# 4i
	add $t1, $s0, $t1		# A + 4i
	
	sw $a0, 0($t1)
	
	add $t0, $t0, 1			# i++
	j input_array
end_input_array:
input_M:
	li	$v0, 51
	la	$a0, Message5
	syscall
	
	beq $a1, -1, input_M
	beq $a1, -3, input_M
	beq $a1, -2, exit
	
	add $s2, $a0, 0			# store M
input_N:
	li	$v0, 51
	la	$a0, Message6
	syscall
	
	beq $a1, -1, input_N
	beq $a1, -3, input_N
	beq $a1, -2, exit
	
	add $s3, $a0, 0			# store N
	
	li $t0, 0				# i
loop:
	beq $t0, $s1, end_loop
	
	add $t1, $t0, $t0		# 2i
	add $t1, $t1, $t1		# 4i
	add $t1, $s0, $t1		# A + 4i
	
	lw $t2, 0($t1)			# A[i]
	
	blt $t2, $s2, continue_loop
	bgt $t2, $s3, continue_loop
	add $s5, $s5,1					# count++
continue_loop:
	add $t0, $t0, 1
	j loop
end_loop:
	bgtz	$s5, print_count
	
	li	$v0, 4
	la	$a0, Message4
	syscall
	
print_count:
	li	$v0, 4
	la	$a0, Message3
	syscall
	
	li $v0, 1						# print count
	add $a0, $s5, 0
	syscall
	
	li $v0, 11						# print '\n'
	li $a0, ' '
	syscall
exit: