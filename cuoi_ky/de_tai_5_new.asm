.data
bieuthuctrungto: .space 256
bieuthuchauto:   .space 256
stack :		  .space 256
mess : 		  .asciiz "nhap bieu thuc trung to : "
messtrungto :	  .asciiz "bieu thuc trung to : "
messhauto : 	  .asciiz "bieu thuc hau to : "
newLine: .asciiz "\n"
.text
 li $v0, 54
 la $a0, mess
 la $a1, bieuthuctrungto
 la $a2, 256
 syscall 
 

li $v0, 4
la $a0, messtrungto
syscall

li $v0, 4
la $a0, bieuthuctrungto
syscall


li $t5,-1 #dem
li $t6,-1 #
li $t7,-1 #
loop1:
li $t1, '+'
li $t2, '-'
li $t3, '*'
li $t4, '/'
la $s1,bieuthuctrungto
la $s2,bieuthuchauto
la $s3,stack
add $t5,$t5,1  # dem ++
add $s1,$s1,$t5 
lb $t9,0($s1) #load gia tri vao t9
# so sanh neu la cac ky tu +, - , * , / 
beq $t9,$t1,toantu  # = '+'
nop
beq $t9,$t2,toantu  # = '-'
nop
beq $t9,$t3,toantu  # = '*'
nop
beq $t9,$t4,toantu  # = '/'
nop
beq $t9, $zero, endWhile
nop
# neu la so
add $t6,$t6,1
add $s2,$s2,$t6
sb $t9,0($s2)
# kiem tra ky tu tiep theo co phai la so hay khong
lb $a1,1($s1)
jal kiemtraso
beq $a0,1, khongphaitoantu
nop
add_space: # them khoang cach vao bieu thuc hau to
	add $t9, $zero, 32 
	sb $t9, 1($s2)
	addi $t6, $t6, 1
	
j loop1
nop 

kiemtraso:
li $t7,'0'
li $t8,'9'
beq $a1,$t7, so # neu = '0'
nop
beq $a1,$t8, so #neu = '9'
nop
slt $a0,$t7,$a1 # neu a0 < '0' thi tiep khong phai la so
beq $a0,$zero, no_so
nop
slt $a0,$a1,$t8 # neu a0 > '9' thi tiep khong phai la so
beq $a0,$zero, no_so
nop

so:
li $a0,1
jr $ra
nop

no_so:
li $a0,0
jr $ra
nop

toantu:
 beq $t7,-1,pushtostack
 nop
 add $s3,$s3,$s7
 lb $a2,0($s3)
 beq $t9,$t1,uu_tien
 nop
 beq $t9,$t2,uu_tien
nop
li $a3,2
j check_2
nop
 uu_tien:
 	li $a3, 1	
 check_2:
  beq $a2,$t1,uu_tien2
 nop
 beq $a2,$t2,uu_tien2
nop
li $s3,2
j so_sanh_uu_tien
nop
 uu_tien2:
 li $s3,1
 
 so_sanh_uu_tien:
 beq $a3,$s3,tuong_duong
 nop
 slt $s4,$a3,$s3
beq $s4,$zero,a3_lon_s3
nop
# neu a3 < s3
# pop a2 ra khoi stack vao hau to
# tao lai ngan xep ban dau

	sb $zero, 0($s3)
	addi $t6, $t6, -1  # scounter ++
	addi $s3, $s3, -1
	la $s2, bieuthuchauto#postfix = $t5
	addi $t6, $t6, 1
	add $s2, $s2, $t6
	sb $a2, 0($s3)
	
	#addi $s7, $s7, -1  # scounter = scounter - 1
	j toantu
	nop
a3_lon_s3:
j pushtostack
	nop
 tuong_duong:
 	sb $zero, 0($s3)
	addi $t6, $t6, -1  # scounter ++
	addi $s3, $s3, -1
	la $s2, bieuthuchauto#postfix = $t5
	addi $t6, $t6, 1
	add $s2, $s2, $t6
	sb $a2, 0($s3)
	j  pushtostack
	nop
 pushtostack:
 	la $s3, stack #stack = $t6
	addi $s7, $s7, 1  # scounter ++
	add $s3, $s3, $s7
	sb $t9, 0($s3)		
	khongphaitoantu:
     	j loop1
      	nop

endWhile:

	addi $s1, $zero, 32
	add $s7, $s7, 1
	add $s2, $s2, $s7 
	la $s3, stack
	add $s3, $s3, $s7
popallstack:

	lb $a2, 0($s3) # t2 = value of stack[counter]
	beq $a2, 0, endPostfix
	sb $zero, 0($s3)
	addi $s7, $s7, -2
	add $s3, $s3, $s7
	
	sb $a2, 0($s2)
	add $s2, $s2, 1
	
	
	j popallstack
	nop

endPostfix:
############################################################################### END POSTFIX
# print postfix
la $a0, messhauto  
li $v0, 4
syscall

la $a0, bieuthuchauto
li $v0, 4
syscall

la $a0, newLine
li $v0, 4
syscall


############################################################################### Caculate

li $s3, 0 # counter
la $s2, stack #stack = $s2
