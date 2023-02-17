.data
Message: .asciiz "Nhap so nguyen:" # kh?i t?o giá tr? cho Message
.text
 li $v0, 51        # v_0 = 51 hi?n th? thông báo t? ??a ch? a_0 cho ng??i dùng và nh?n d? li?u input t? ng??i dùng 
 la $a0, Message   # gán ??a ch? a_0 là ??a ch? Message
 syscall 