.data
Message: .asciiz "So nguyen la " # khai báo Message có giá tr? kh?i t?o là "So nguyen la"
.text
 li $v0, 56 # thanh ghi V_0 ???c gán giá tr? 56 t??ng ?ng d?ch v? hi?n th? thông tin cho ng??i dùng ? n?i ch?a ??a ch? a_0 ?ang có và in a_1 sau chu?i ??u tiên k?t thúc
 la $a0, Message # kh?i t?o thanh ghi a_0 v?i ??a ch? c?a Message 
 li $a1, 0x307 # the interger to be printed is 0x307
 syscall # execute