#Long Hoang (Individual)

#github project link: https://github.com/longhoag/CS2640/blob/main/inclass2.asm

# CS 2640.04
#Assingment prompt: The prompt was posted on canvas. I'm doing the In-Class Practice: Two Parameters and String Practice
#Task: write a MIPS program that passes the programmer’s defined string to the macro, uses a loop to print the string 3 times (each on a new line), and then exits the program.
# November 15, 2023


#print string macro
.macro printString(%strings)
	.data 
	string: .asciiz %strings
	
	.text
	li $v0, 4
	la $a0, string
	syscall
.end_macro

#print int 
.macro printInt(%x)
	li $v0, 1
	add $a0, $zero, %x
	syscall

.end_macro

#aString macro
.macro aString(%int, %strings)
	li $t1, 2
	mul $t0, $t1, %int #t0 = 2 * %int (double)
	
	#printInt($t0)
	
	#print string
	printString(%strings)
	
.end_macro


.data

.text
main:
	#initiate counter 
	li $t2, 0
	
	j loop

loop:
	beq $t2, 3, exit
	aString(2, "hello\n")
	addi $t2, $t2, 1
	
	j loop

#exit label
exit:
li $v0, 10
syscall
