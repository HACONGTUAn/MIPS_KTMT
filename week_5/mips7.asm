.data
Message: .space 100 # Buffer 100 byte chua chuoi ki tu can (.space c?p ph�t b? nh?)
.text
 li $v0, 8 # ??c chu?i
 la $a0, Message # g�n ??a ch? Message cho a_0
 li $a1, 100   # s? k� t? t?i ?a ?? ??c
 syscall