.data
result: .word 0
errorMsg: .asciiz "N<0 is invalid"
inputMsg: .asciiz "Enter a number: "
newLine: .asciiz "\n"

.text
.globl main
main:
#save value of result to register $s2
la $t2, result
sw $s2, 0($t2)

#print out inputRequest
li $v0, 4
la $a0, inputMsg
syscall

#get user input 1st integer argument
li $v0, 5
syscall

#move input to $s1
move $s1, $v0

#go to error if $s1 is less than 0
bltz $s1, error

#go to fin if $s1 is less than 2
blt $s1, 2, fin

addi $t3, $0, 0 #initialize $t3 with 0 which will be used to increment

fori:
addi $t3, $t3, 2 #increment by 2 so only even numbers are added
add $s2, $s2, $t3 #add that value to result
sw $s2, result #save result

sub $t4, $s1, $t3 #take the difference between N and incremen

#fins the loop if N - $t3 <= 0 i.e., $t3 is greater than or equal to N
blez $t4, fin

#continues to loop if N - $t3 >= 2, ie. there is one or more even number <= N
bge $t4, 2, fori

#else if N- $t3 is greater than 0 but less than 2, N-$t3 equals 1 which means N is odd, $t3 is at the last 
#even number before N and the loop should end, otherwise $t3 will increment to N+t and the loop will never end
beq $t4, 1, fin

error:
addi $s2, $0, -1 #set result to -1
sw $s2, result #save result

#print out error message
li $v0, 4
la $a0, errorMsg
syscall

#print out new line
la $a0, newLine
syscall

#print out result
li $v0, 1
lw $a0, result
syscall
j exit

fin:
#print out result
li $v0, 1
lw $a0, result
syscall
j exit

exit:
li $v0, 10
syscall
