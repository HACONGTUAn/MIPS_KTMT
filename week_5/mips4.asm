.data
Message: .asciiz "Bomon \nKy thuat May tinh:" # kh?i t?o giá tr? cho Message
Address: .asciiz " phong 502, B1"             # kh?i t?o giá tr? cho Address
.text
 li $v0, 59      # d?ch v? in chu?i t? ??a ch? a_0 sau khi k?t thúc a_0 thì hi?n th? giá tr? c?a ??a ch? a_1
 la $a0, Message
 la $a1, Address 
 syscall 