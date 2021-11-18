	.data	
inputMsg: .asciiz "Enter a number: "

	.text
	.globl main
main:
	#print out inputRequest
	li $v0, 4
	la $a0, inputMsg
	syscall
	
	#get user input 1st integer argument
	li $v0, 5
	syscall
	
	#move input to $s1
	move $s1, $v0
	
	#print out inputRequest
	li $v0, 4
	la $a0, inputMsg
	syscall
	
	#get user input 2nd integer argument
	li $v0, 5
	syscall
	
	#move input to $s2
	move $t2, $v0

	addi $s3, $zero, 0
	blez $s1, fin
	blez $t2, fin
fori:
	add	$s3, $s3, $s1
	addi	$t2, $t2, -1
	bnez	$t2, fori		
fin:
	#print out result
	li $v0, 1
	move $a0, $s3
	syscall
	
	li	$v0, 10
	syscall	
