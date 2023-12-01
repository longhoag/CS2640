#take user input string
.macro getInput(%location)
	.data 
	buffer: .space 50
	.text
	
	printString("Please enter your input: ")

	li $v0, 8
	la $a0, buffer #load address of 'buffer' into $a0
	li $a1, 50  #50 characrers read by syscall
	syscall
	
	move %location, $a0 #store string in t0
.end_macro

#add 2 int
.macro addition(%location, %int1, %int2)

	add $t0, %int1, %int2
	move %location, $t0

	#print
	#li $v0, 1
	#move $a0, $s1
	#syscall
.end_macro

#print int macro
.macro printInt(%int)
    	li $v0, 1
    	move $a0, %int
    	syscall
.end_macro


#print string macro
.macro printString(%strings)
	.data 
	string: .asciiz %strings
	
	.text
	li $v0, 4
	la $a0, string
	syscall
.end_macro

.macro getInteger(%location)
	li $v0, 5
	syscall 
	
	#store in $t1
	move %location, $v0
	
	#print 
	#li $v0, 1
	#move $a0, %location
	#syscall

.end_macro


.data 


.text
main:
	printString("Please select an operation to complete: \n 1) addition \n 2) substraction \n 3) multiplication \n 4) division\n")
	printString("Please enter a number 1-4: ")
	
	getInteger($t1)

	printString("\nPlease enter an integer: ")
	getInteger($t2)
	printString("\nPlease enter an integer: ")
	getInteger($t3)
	
	
	beq $t1, 1, addition
	beq $t1, 2, substraction
	beq $t1, 3, multiplication
	beq $t1, 4, division
	
addition:
	#add $t4, $t2, $t3
	addition($t4, $t2, $t3)
	j continue

substraction:
	sub $t4, $t2, $t3
	j continue
multiplication:
	mul $t4, $t2, $t3
	j continue
division: 
	div $t4, $t2, $t3
	j continue
	
continue:	
	
	printString("\nThe result is: ")
	li $v0, 1
	move $a0, $t4
	syscall
	
	j exit
exit:
	li $v0, 10
	syscall

#project link if there's any problem: https://github.com/longhoag/CS2640/blob/main/quiz4.asm
	
	
