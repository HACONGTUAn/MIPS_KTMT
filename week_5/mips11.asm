.data
Message: .asciiz "Ban la SV Ky thuat May tinh?"
.text
 li $v0, 50 # ??c chu?i t? ??a ch? a_0 v� hi?n th? th�ng b�o yes(a_0=0), no(a_0 = 1) ,cancel(a_0 = 2)
 la $a0, Message # g�n ??a ch? Message cho a0
 syscall 