.data
	A: .word 2,3,4,5
.text
	addi $s3, $zero, 4
	addi $s5, $zero, 0
	la $s2, A
	addi $s1, $zero, 0
	addi $s4, $zero, 1
loop: 

add $t1,$s1,$s1 #t1=2*s1
add $t1,$t1,$t1 #t1=4*s1
add $t1,$t1,$s2 #t1 store the address of A[i]
lw $t0,0($t1) #load value of A[i] in $t0
add $s5,$s5,$t0 #sum=sum+A[i]
add $s1,$s1,$s4 #i=i+step
bne $s1,$s3,loop #if i != n, goto loop
