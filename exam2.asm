#Long Hoang (Individual)

#github project link: https://github.com/longhoag/CS2640/blob/main/exam2.asm

# CS 2640.04
#Assingment prompt: Write a program in MIPS assembly that takes in two user strings and prints our their addresses after printing out all elements for the days array provided. 

# November 17, 2023

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


#get user string
.macro getString
	printString("Please enter a string (max 50 characters): ")

	li $v0, 8
	la $a0, buffer #load address of 'buffer' into $a0
	li $a1, 50 #50 characrers read by syscall
	syscall
	
	move $s1, $a0
	
.end_macro

#print address
.macro printA

	la $a0 , buffer
	move $a0, $s1
	li $v0, 1
	syscall

.end_macro



.data
days: .word 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31

buffer: .space 50



.text
main:
	
	#GET STRINGS
	#first
	getString
	
	#second 
	getString

	#PRINT ARRAY
	#load base address of array
    	la $s0, days
    
    	#initialize counter ($t0)
    	li $t0, 0
    
    	printString("Days array elements are: ")
    	
    	j loop
    	
loop:
    	#condition to continue task loop
    	beq $t0, 12, cont   #if counter reaches 12 (array length), then exit
    
    	#load current array element in to $t1
    	lw $t1, 0($s0)
    
    	#print out the current integer
    	#li $v0, 1
    	#move $a0, $t0
    	#syscall
    	printInt($t1)
    
   	#space for formatting
   	printString(" ")
    
   	#advance base address to get to next element
   	addi $s0, $s0, 4
    
   	#counter++
   	addi $t0, $t0, 1
    
   	j loop
   	
cont: 
	printString("\nThe address for first string is: ")
	
	printA
	
	printString("\n")
	printString("The address for second string is: ")
	printA
	
	printString("\n")
	
	j exit

exit:
    printString("The program will now exit\n")
    li $v0, 10
    syscall