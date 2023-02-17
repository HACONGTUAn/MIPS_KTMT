#Laboratory Exercise 5, Home Assignment 2
.data
x: .space 1000 # destination string x, empty
y: .asciiz "Hello" # source string y
.text
addi $t1,$zero,0
addi $t2,$zero,0
addi $t3,$zero,0
strcpy:
add $s0,$zero,$zero #s0 = i=0

L1:
add $t1,$s0,$a1 #t1 = s0 + a1 = i + y[0]
 # = address of y[i]
lb $t2,0($t1) #t2 = value at t1 = y[i] / ch�p 1 byte t?i v?i tr� trong b? nh? Ram v�o byte th?p c?a thanh ghi
add $t3,$s0,$a0 #t3 = s0 + a0 = i + x[0] 
 # = address of x[i]
sb $t2,0($t3) #x[i]= t2 = y[i] / l?u 1 byte th?p trong thanh ghi v�o v? tr? trong b? nh? Ram
beq $t2,$zero,end_of_strcpy #if y[i]==0, exit
nop # m� m�y ??u b?ng 0
addi $s0,$s0,1 #s0=s0 + 1 <-> i=i+1
j L1 #next character
nop
end_of_strcpy: