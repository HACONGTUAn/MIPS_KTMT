.data
Message: .asciiz "Nhap so nguyen:" # kh?i t?o gi� tr? cho Message
.text
 li $v0, 51        # v_0 = 51 hi?n th? th�ng b�o t? ??a ch? a_0 cho ng??i d�ng v� nh?n d? li?u input t? ng??i d�ng 
 la $a0, Message   # g�n ??a ch? a_0 l� ??a ch? Message
 syscall 