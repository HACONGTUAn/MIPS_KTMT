li $t2,3
li $s6,4
bne $t2,$s6,L1
add $t2,$s6,0
add $t2,$s6,0
add $t2,$s6,0
bne $t2,$s6,L2
bne $s6,$t2,L2
L1:lw $t3,64($s4)
L2: