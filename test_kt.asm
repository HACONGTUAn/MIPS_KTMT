.data
array: .space 40
.text
li $t1,0x2B1AFFFF
la $s6,array
lui $s0,0x891E
ori $s0,$s0,0xA581
addi $s1,$s0,-129
sw $s0,0($s6)
lb $s2,1($s6)

