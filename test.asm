.data
li $s0,1
li $s1,2
.text
add $t0,$s0,$s1
beq $t0,$0,loop
add $t0,$0,$s1
add $t0,$0,$s1
add $t0,$0,$s1
add $t0,$0,$s1
add $t0,$0,$s1
add $t0,$0,$s1
add $t0,$0,$s1
add $t0,$0,$s1
loop:add $t0,$0,$s1

