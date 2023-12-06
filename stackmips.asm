#Long Hoang (Individual)

#github project link: https://github.com/longhoag/CS2640/blob/main/stackmips.asm

# CS 2640.04
#Assingment prompt: Write a program in Assembly that reverses the elements of the given array. int array = [5, 4, 3, 2, 1]

# December 5, 2023


#print string macro
.macro printString(%strings)
	.data 
	string: .asciiz %strings
	
	.text
	li $v0, 4
	la $a0, string
	syscall
.end_macro

#print int macro
.macro printInt(%int)
    	li $v0, 1
    	move $a0, %int
    	syscall
.end_macro

.data

array: .word 5, 4, 3, 2, 1

.text
main:
	printString("Array elements are: ")
	#load base address of array
    	la $s0, array
    
    	#initialize counter ($t1)
    	li $t1, 0
    	
    	j loop

loop:
    	#condition to exit loop
    	beq $t1, 5, continue   #if counter reaches 5, then exit
    
    	#load current array element in to $t0
    	lw $t0, 0($s0)
    
    	#print out the current integer
    	printInt($t0)
    	
    	#space for formatting
    	printString(" ")
    
    	#advance base address to get to next element
    	addi $s0, $s0, 4
    	
    
    	#counter++
    	addi $t1, $t1, 1
    
    	j loop
    	
continue:
	printString("\nNew array is: ")

	#initialize another counter ($t2)
    	li $t2, 0
    	
    	j reverse
    	
reverse:
	#condition to exit loop
    	beq $t2, 5, exit   #if counter reaches 5, then exit
    	
	
	#load the last array element in to $t3
    	lw $t3, -4($s0)
    	
    	# print the current element
    	printInt($t3)
	
	#space for formatting
    	printString(" ")
    
    	#reduce base address to get to previous element
    	sub $s0, $s0, 4
    	
    	#counter++
    	addi $t2, $t2, 1
    
    	j reverse
	
    
exit:
    li $v0, 10
    syscall
