.data
stackPointer: .asciiz "The current stack address is: "

.text 
main:

	#print the prompt and current address
	li $v0, 4
	la $a0, stackPointer 
	syscall
	
	li $v0, 1
	move $a0, $sp
	syscall
	
	#pop $s1 = 4
	lw $
	
	#push int onto stack
	li $s0, 3 #s0 = 3
	sw $s0, ($sp)
	sub $sp, $sp, 4
	
	
	
	#exit
	li $v0, 10
	syscall
	
	
	
	