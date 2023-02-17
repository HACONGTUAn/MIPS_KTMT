.data
array : .space 40
mess: .asciiz "nhap do dai mang : "
mess2: .asciiz "nhap phan tu : "
mess3: .asciiz "so lan chuyen doi : "
.text
la $t1,array #luu dia chi mang vao thanh ghi t1
li $s3,0
li $s2,0
li $s4,1
li $t9 ,0#bien dem 
li $v0,4
la $a0,mess
syscall
li $v0,5
syscall 
add $s0,$v0,$0 #s0 = v0
sub $t2,$s0,$s4 #t2 = S0 -1
mul $t2,$t2,4
add $t3,$t1,$t2 # dia chi cu phan tu mang cuoi cho t3

#nhap mang
loop:
beq $s0,$0,loop1 
li $v0, 4
la $a0,mess2
syscall
li $v0,5
syscall
sw $v0,array($s3)
add $s3,$s3,4
sub $s0,$s0,$s4
j loop
# xet cac phan tu
loop1:

lw $s5,($t1)
add $t1,$t1,4
lw $s6,($t1)
slt $t8,$s5,$s6# neu s5 < s6
beq $t8,$4,true 
slt $t8,$s5,$s6 #neu s5 > s6
beq $t8,$zero,false
bne $t8,$zero,false
true:
beq $t1,$t3,exit
j loop1

false:
add $s6,$s6,$s4
add $t9,$t9,$s4
sw $s6,0($t1)
beq $t1,$t3,false1
j loop1

false1:
add $s6,$s6,$s4
add $t9,$t9,$s4
sw $s6,0($t1)
lw $s6,0($t1)
sub $t1,$t1,4
lw $s5,0($t1)
slt $t8,$s5,$s6# neu s5 < s6
beq $t8,$4,exit

exit:
li $v0,4
la $a0,mess3
syscall
li $v0,1
la $a0,($t9)
syscall