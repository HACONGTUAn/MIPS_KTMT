#Laboratory Exercise 5, Home Assignment 1
.data
test: .asciiz "Hello World" # kh?i t?o giá tr? cho test
.text
 li $v0, 4 # D?ch v? ??c m?t chu?i string t? ??a ch? a_0
 la $a0, test # gán ??a ch? test cho a_0
 syscall 