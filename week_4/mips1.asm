
add $s1,$zero,-255
add $s2,$zero,-2

.text

start: 
li $t0,0
addu $s3,$s1,$s2
xor $t1,$s1,$s2
bltz $t1, EXIT
slt $t2,$s3,$s1
bltz $s1,NEGTIVE
beq $t2,$zero,EXIT
j OVERFLOW
NEGTIVE:
bne $t2,$zero,EXIT
OVERFLOW:
li $t0,1
EXIT: