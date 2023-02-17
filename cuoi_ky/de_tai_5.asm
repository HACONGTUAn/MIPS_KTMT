.data
stack: .space 256
trung_to: .space 256
hau_to:.space 256
mess: .asciiz "nhap bieu thuc trung to : "
mess1: .asciiz "bieu thuc trung to : "
mess2: .asciiz "bieu thuc hau to : "
mess3: .asciiz "gia tri bieu thuc : "
.text
li $v0, 4
la $a0,mess
syscall

li $v0, 8
la $a0 , trung_to
li $a1,255
syscall 
li $s6,-1
li $s7,-1
li $t8,-1
while:
la $s0,trung_to
la $s1,hau_to
la $s2,stack
li $t0 ,'+'
li $t1,'-'
li $t2,'*'
li $t3,'/'
add $s6,$s6,1
add $s0,$s0,$s6
lb $s3,0($s0)
#so sanh de tim toan_tu
beq $s3,$t0,toan_tu
beq $s3,$t2,toan_tu
beq $s3,$t3,toan_tu
beq $s3,$t4,toan_tu
beq $s3, 10,end_while# '\n'
beq $s3,$zero,end_while
#neu khong phai toan tu thi la 1 so
add $s7,$s7,1
add $s1,$s1,$s7 # tang dia chi len 
sb $s3,0($s1)
lb $s4,1($s0)
jal kiem_tra_so
beq $v0,$zero,space
j while
nop

space:
li $a0,32
sb $a0,1($s1)
add $s7,$s7,1
j while
nop


kiem_tra_so:
li $t4,'0'
li $t5, '9'
beq $s4,$t4,so
nop
beq $s4,$t5,so
nop
slt $s5,$t4,$s4
beq $s5,$zero, khong_phai_so
slt $s5,$s4,$t5
beq $s5,$zero, khong_phai_so
so:
li $v0,1
jr $ra
khong_phai_so:
li $v0,0
jr $ra

toan_tu:
#neu la toan tu dau tien 
beq $t8, -1 , push_stack
#neu khong phai toan tu dau tien 
lb $t7,0($s2)
beq $s3,$t0,uu_tien
nop
beq $s3,$t1,uu_tien
nop
beq $s3,$t2,uu_tien2
nop
beq $s3,$t3,uu_tien2
nop
# tim muc uu tien cho toan tu truoc
kiem_tra_toan_tu_truoc:
beq $t7,$t0,uu_tien3
nop
beq $t7,$t1,uu_tien3
nop
beq $t7,$t2,uu_tien4
nop
beq $t7,$t3,uu_tien4
nop
j so_sanh_uu_tien

so_sanh_uu_tien:
beq $a2,$a3,pop_stack
nop
slt $v0,$a2,$a3# neu toan tu sau > toan tu truoc thi them vao stack
beq $v0,1,push_stack
j pop_stack

uu_tien:
li $a2,1
j kiem_tra_toan_tu_truoc
uu_tien2:
li $a2,2
j kiem_tra_toan_tu_truoc
uu_tien3:
li $a3,1
j so_sanh_uu_tien
uu_tien4:
li $a3,2
j so_sanh_uu_tien

pop_stack:
add $s7,$s7,1
add $s1,$s1,$s7
sb $t7,0($s1)
j while

push_stack:
add $t8,$t8,1
add $s2,$s2,$t8
sb $s3, 0($s2)
j while 

end_while:
	#dua moi toan tu con lai trong stack vao hau to neu con
	la $s2,stack
	li $t8,-1
	all_stack:
	add $t8,$t8,1
	add $s2,$s2,$t8
	lb $t7,0($s2)
	sb $zero,0($s2)
	beq $t7,$zero,end
	add $s7,$s7,1
	add $s1,$s1,$s7
	sb $t7,0($s1)
	j all_stack
end:
li $v0, 4
la $a0,mess2
syscall


li $v0, 4
la $a0,hau_to
syscall



