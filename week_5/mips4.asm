.data
Message: .asciiz "Bomon \nKy thuat May tinh:" # kh?i t?o gi� tr? cho Message
Address: .asciiz " phong 502, B1"             # kh?i t?o gi� tr? cho Address
.text
 li $v0, 59      # d?ch v? in chu?i t? ??a ch? a_0 sau khi k?t th�c a_0 th� hi?n th? gi� tr? c?a ??a ch? a_1
 la $a0, Message
 la $a1, Address 
 syscall 