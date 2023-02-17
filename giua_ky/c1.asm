# Palindrome
.data 
	inputString: .space 51

	INPUT_STRING_MESSAGE: .asciiz "Enter a string (under 50 character): "
	NOT_IS_PALINDROME_MESSAGE: .asciiz "This string is not a palindrome"
	IS_PALINDROME_MESSAGE: .asciiz "This string is a palindrome"
	RESULT: .asciiz "RESULT:\n"
	ERROR: .asciiz "ERROR!!!\n"
	TOO_LONG_STRING_MESSAGE: .asciiz "String too long!"
.text
main:
#--------------------------------------------------------------------------------------------
# @brief	Nhan vao 1 xau tu nguoi dung
#--------------------------------------------------------------------------------------------
getString:
	li $v0, 54
	la $a0, INPUT_STRING_MESSAGE
	la $a1, inputString
	la $a2, 51
	syscall
#--------------------------------------------------------------------------------------------
# @brief		Tim do dai 1 xau
# @param[in]	$s0	Dia chi string can tim do dai
# @param[out]	$s1	Do dai cua string
# @param[out]	$t1	Chi so cua ki tu cuoi cung (Tinh tu 0)
#--------------------------------------------------------------------------------------------
getLength:
	la $s0, inputString
	addi $s1, $zero, 0	#s1 = length = 0
	addi $t1, $zero, 0	#t1 = i = 0
	findNullChar:
		add $t2, $s0, $t1	#t2 = pointer = inputString + i 
		lb $t3, 0($t2) 		#t3 = inputString[i]
		
		beq $t3, $zero,finishGetLength #if inputString[i] == '\0' -> finishGetLength
		
		addi $s7, $zero, 10
		beq $t3, $s7, updateString#if inputString[i] == '\n' -> bo di '\n'
		
		addi $s1, $s1, 1
		addi $t1, $t1, 1
		j findNullChar
	updateString:
		add $t1, $s0, $t1
		sb $zero, 0($t1)
	finishGetLength:
		add $t1, $zero, $s1 #i = length
		#i = length - 1 (dua i ve phan tu cuoi cung)
		addi $t1, $t1, -1
#--------------------------------------------------------------------------------------------
# @brief		Kiem tra xem xau nhap vao co dai qua 49 khong
# @param[in]	$s1	Do dai cua inputString
# @param[out]		In ra thong bao neu dai hon 49
#--------------------------------------------------------------------------------------------		
isTooLongString:
	slti $t2, $s1, 50
	beq $t2, $zero, putErrorStringMessage
#--------------------------------------------------------------------------------------------
# @brief		Kiem tra xem inputStringn co phai palindrome khong
# @param[in]	$s0	Dia chi cua inputString
# @param[in]	$s1	Do dai cua inputString
# @param[in]	$t1	Chi so cua ki tu cuoi cung cua inputString (Tinh tu 0)
# @param[out]		Thong bao ra man hinh
#--------------------------------------------------------------------------------------------		
add $t1, $zero, $s1
addi $t1, $t1, -1 
addi $t2, $zero, 0	#t2 = j = 0
checkPalindrome:		
		
	add $t3, $s0, $t2	#t3 = inputString + t2
	lb $t3, 0($t3)		#t3 = inputString[0]
	
	add $t4, $s0, $t1	#t4 = inputString + t1
	lb $t4, 0($t4)		#t4 = inputString[length]
	bne $t3, $t4, notIsPalindrome
	addi $t1, $t1, -1 	#i--
	addi $t2, $t2, 1	#j++
	slt $t5, $t2, $t1	#j < i?
	beq $t5, $zero, isPalindrome
	j checkPalindrome
	
	notIsPalindrome:
		la $a1, NOT_IS_PALINDROME_MESSAGE
		li $v0, 59
		la $a0, RESULT
		syscall
		j exit
	isPalindrome:
		la $a1, IS_PALINDROME_MESSAGE
		li $v0, 59
		la $a0, RESULT
		syscall
		j exit
#--------------------------------------------------------------------------------------------
# @brief		Hien ra cac message
# @param[out]		In message ra console hoac man hinh
#--------------------------------------------------------------------------------------------	
putErrorStringMessage:
	la $a1, TOO_LONG_STRING_MESSAGE
	li $v0, 59
	la $a0, ERROR
	syscall
	j main
exit: