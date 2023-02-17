.data
mess : .asciiz "nhap so N : "
sochiaba : .asciiz "so chia het cho ba : "
sochianam :.asciiz "so chia het cho nam : "
.text
li $t9 1
li $t2 3
li $t3 5
li $v0 4
la $a0,mess
syscall
li $v0 5
syscall
add $s0,$zero,$v0 #s0 = v0
add $s1,$0,$s0
bne $s0,$0,chiaba

chiaba:
beq $s0,$0,chianam
div $s0,$t2
mfhi $t1 #so du
beq $t1,$0,dayso

loop:
sub $s0,$s0,$t9
j chiaba

dayso:
li $v0 1
la $a0,($s0)
syscall
li $v0, 11
 li $a0, ' '			#in kí t? cách
 syscall 
j loop

chianam:
add $s0,$s1,$0
j loop2

loop2:
beq $s0,$0,ketthuc
div $s0,$t3
mfhi $t5
beq $t5,$0,dayso2

thuong:
sub $s0,$s0,$t9
j loop2



dayso2:
li $v0 1
la $a0,($s0)
syscall
li $v0, 11
li $a0, ' '			#in kí t? cách
 syscall 
j thuong

ketthuc:


