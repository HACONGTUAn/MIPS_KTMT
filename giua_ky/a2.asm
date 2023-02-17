.data 
mess: .ascii "nhap so N: "
.text
li $t1,0 # phan tu dau tien cua day fibonasi
li $t2,1 #phan tu tiep theo cua day fibonasi
li $v0,4
la $a0,mess
syscall
li $v0,5
syscall
add $s0,$v0,$0 # gan s0 = v0
bne $s0,$zero,fibonasi

fibonasi:
add $t3,$t1,$t2 # phan tu tiep theo cua say x3 = x2+x1
add $t1,$t2,$0  # x1 = x2
add $t2,$t3,$0 # x2 = x3
slt $s2,$s0,$t3 # neu N < x3
bne $s2,$0,end
li $v0 1
la $a0,($t3)
syscall
li $v0 11
li $a0, ' '			
syscall 
j fibonasi
end:




