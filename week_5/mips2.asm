.data
Message: .asciiz "So nguyen la " # khai b�o Message c� gi� tr? kh?i t?o l� "So nguyen la"
.text
 li $v0, 56 # thanh ghi V_0 ???c g�n gi� tr? 56 t??ng ?ng d?ch v? hi?n th? th�ng tin cho ng??i d�ng ? n?i ch?a ??a ch? a_0 ?ang c� v� in a_1 sau chu?i ??u ti�n k?t th�c
 la $a0, Message # kh?i t?o thanh ghi a_0 v?i ??a ch? c?a Message 
 li $a1, 0x307 # the interger to be printed is 0x307
 syscall # execute