#CS 2640.04
# November 20th 2023
# write a program that will 
# 1. print out '$sp' address
# 2. push an integer onto the stack
# 3. print out the new '$sp address'

.data
stackPointer: .asciiz "\nThe current stack address is: "

.text
main:
	#print out the prompt and current address
	li $v0 , 4
	la $a0, stackPointer
	syscall
	li $v0, 1
	move $a0, $sp
	syscall
	
	#push int onto stack
	li $s0, 3        #$s0 = 3
	sw $s0, ($sp)
	sub $sp, $sp, 4
	
	#print out new $sp (address)
	li $v0 , 4
	la $a0, stackPointer
	syscall
	li $v0, 1
	move $a0, $sp
	syscall
	
	#pop $s1=4
	lw $t0, ($sp)
	add $sp, $sp, 4
	
	#print out $sp (address)
	li $v0, 4
	la $a0, stackPointer
	syscall
	li $v0, 1
	move $a0, $sp
	syscall
	
	#push int onto stack
	li $s1, 4
	sw $s1, ($sp)
	sub $sp, $sp, 4
	
	#exit program
	li $v0, 10
	syscall