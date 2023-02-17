.data
Message: .asciiz "Bomon \nKy thuat May tinh" # kh?i t?o giá tr? cho Massage
.text
 li $v0, 4 # t??ng ?ng v?i d?ch v? in chu?i t? a_0
 la $a0, Message # a_0 ???c gán ??a ch? c?a Message
 syscall