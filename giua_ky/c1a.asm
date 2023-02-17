.data
INPUT_STRING_MESSAGE: .asciiz "nhap xau "
inputString: .space 51
.text

getString:
	li $v0, 54
	la $a0, INPUT_STRING_MESSAGE
	la $a1, inputString
	la $a2, 51
	syscall