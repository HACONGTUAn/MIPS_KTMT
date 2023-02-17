.data
array : .space 40
mess: .asciiz "nhap do dai mang : "
mess2: .asciiz "nhap phan tu : "
mess3: .asciiz "so lan chuyen doi : "
mess4: .asciiz "do dai mang khong the la so am duoc " 
msg:   .asciiz "khong duoc nhap ky tu"
.text
la $t1,array #luu dia chi mang vao thanh ghi t1
li $s3,0
li $s2,0
li $s4,1
li $t9 ,0#bien dem 
li $v0,51
la $a0,mess
syscall 
#loi neu nhap vao la ky tu
teqi $a0,0     
   .ktext 0x80000180
   move $k0,$v0   # Save $v0 value
   move $k1,$a0   # Save $a0 value
   la   $a0, msg  # address of string to print
   li   $v0, 4    # Print String service
   syscall
   move $v0,$k0   # Restore $v0
   move $a0,$k1   # Restore $a0
   mfc0 $k0,$14   # Coprocessor 0 register $14 has address of trapping instruction
   addi $k0,$k0,4 # Add 4 to point to next instruction
   mtc0 $k0,$14   # Store new address back into $14
   eret           # Error return; set PC to value in $14
   

slt $t0,$a0,$0
beq $t0,1,loiam
add $s0,$a0,$0 #s0 = v0
sub $t2,$s0,1 #t2 = S0 -1

#nhap mang
loop:
beq $s0,$0,for 
li $v0,51
la $a0,mess2
syscall
sw $a0,array($s3)
add $s3,$s3,4
sub $s0,$s0,$s4
j loop
nop

for :
beq $t2,$0,exit
lw $s5,($t1)
add $t1,$t1,4
lw $s6,($t1)
slt $t8,$s5,$s6
beq $t8,1,for1
j else
nop

for1:
sub $t2,$t2,1
j for
nop

else:
add $s6,$s6,$s4
add $t9,$t9,$s4
sw $s6,0($t1)
lw $s6,0($t1)
sub $t1,$t1,4
lw $s5,0($t1)
slt $t8,$s5,$s6
beq $t8,1,for
j else1
nop

else1:
add $t1,$t1,4
j else
nop

exit:
li $v0,56
la $a0,mess3
la $a1,($t9)
syscall
j end
nop

loiam:
li $v0 ,56
la $a0,,mess4
syscall
j end
end:

