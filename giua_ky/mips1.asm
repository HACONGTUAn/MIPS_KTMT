.data
Mess :.asciiz "nhap so : "
loiso :.asciiz "so ban nhap co so phan tu le khong tinh duoc"
loisoam: .asciiz "so ban nhap la so am khong tinh duoc"
mayman :.asciiz " so nay la so may man "
khongmay: .asciiz " so nay khong phai so may man"
khongtinh: .asciiz " so 0 khong duoc tinh "
.text
li $t1 0  	# tong tat ca cac so
li $t2 0  	# tong cac phan tu
li $t6 0  	# dem so phan tu 
li $v0 4 
la $a0 , Mess
syscall
li $v0 5
syscall
add $s1,$v0,$0 		# s1 = v0 gan
slt $s0, $s1,$zero 	# so sanh s1 < 0 neu dung thi s0 = 1 sai s0 = 0
bne $s0,$zero,error	# neu s0 != 0 thi nhay den error
# loop : tính t?ng ph?n t? c?a m?ng
loop:
li $t3 10 
beq $s1,$0,Loop2
div $s1,$t3		#s1/10
mflo $s1 		# gan gia tri thuong cho thanh ghi s1
mfhi $t4 		# gan gia tri so du cho thanh ghi t4
add $t1,$t1,$t4 	# t1= t1 + t4
add $t6,$t6,1
j loop
#loop2 : kiem tra xem xau co phai la sau chan hay khong
# neu la xau co phan tu le thi nhay den nhan error2
# gán l?i s? giá tr? cho thanh ghi s1
# kiem tra xem xau nhap co phai la 0 hay khong false nhay den nhan "so"
# neu t8 = 0 thi endMain
Loop2:
li $t3 2
div $t6,$t3 		# t6/t3
mfhi $t7 		# so du luu vao t7
mflo $t8 		# do dai cua nua so
bne $t7,$0,error2 	# la so le
add $s1,$v0,$0
bne $t8,$0,so 		# kiem tra xem xau nhap co phai la so 0
li $v0 4
la $a0, khongtinh
syscall
j endMain
# so : tinh tong nua phan tu 
# sau do nhay den nha so1
so:
li $t3 10
beq $t8,$0,so1
div $s1,$t3
mfhi $t4
mflo $s1
add $t2,$t2,$t4
sub $t8,$t8,1
j so
#so1: so sanh gia tri thanh ghi t9,t2
# bang thi nhay den nhan somayman
# khong thi in ra man hinh la so khong may nam
so1:
sub $t9,$t1,$t2 #t9 = t1-t2
beq $t9,$t2,somayman
li $v0 4
la $a0, khongmay
syscall
j endMain

somayman:
li $v0 4
la $a0, mayman
syscall
j endMain

error2:
li $v0 4
la $a0, loiso
syscall
j endMain

error:
li $v0 4
la $a0, loisoam
syscall
endMain:
