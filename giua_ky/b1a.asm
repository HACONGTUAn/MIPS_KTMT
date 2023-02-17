.data
array : .space 25
mess : .ascii "nhap phan tu : "
mess1 : .ascii "nhap do dai mang : "
.text
la $s0,array
li $s2,0
li $s3,0
li $t9,1
li $v0,4
la $a0,mess1
syscall
li $v0,5
syscall
add $t1,$v0,$0
j lood

lood:
beq $t1,$0,exit
li $v0,4
la $a0,mess
syscall
li $v0 ,5
syscall
add $s3,$s2,$s2
add $s3,$s3,$s3
add $s3,$s0,$s3
sw $v0,0($s3)
add $s2,$s2,1
sub $t1,$t1,$t9
j lood

exit:
li $s2,0
add $s3,$s2,$s2
add $s3,$s3,$s3
add $s3,$s0,$s3
lw $s4,0($s3)
li $v0 ,1
la $a0,($s4)
syscall
