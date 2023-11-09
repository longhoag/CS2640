#Long Hoang (Individual)

#github project link: https://github.com/longhoag/CS2640/blob/main/hw2task1.asm

# CS 2640.04
#Assingment prompt: The prompt was posted on canvas. I'm doing the program 2: Practice with Conditionals and Loops
#Task 2: Advanced Math: x to the power of y
# November 8, 2023

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

#example for user
.macro tutorial
	printString("This program asks the user to input a value for 'x' and 'y'.\n Then, it finds the value of x to the power of y.\n For example, 2 to the power 3 is 8.")
.end_macro


.data

.text 

main:

#get the input for x
printString("Enter a number for 'x': ")
	
li $v0, 5
syscall
move $s0, $v0 #store x value in s0

#get the input for y
printString("Enter a number for 'y': ")
	
li $v0, 5
syscall
move $s1, $v0 #store x value in s1

#initialize counter ($t0)
li $t0, 0

#initialize temp value = 1 ($t1)
li $t1, 1

beqz $s1, zeroExpo

blt $s1, $zero, negative

j loop 

#if y is 0, return 1
zeroExpo:
	printString("'x' to the power 'y' is: 1")
	j exit

#if y is negative, re prompt
negative:
	printString("\n---------------------------------\n")
	j main
	

loop:
    #condition to exit loop, 'y' times multiplication of 'x'
    beq $t0, $s1, result
    mul $t1, $t1, $s0
    
    #counter ++
    addi $t0, $t0, 1
    
    j loop

#print result 
result:
	printString("'x' to the power 'y' is: ")
	printInt($t1)
	j exit
	
exit:
li $v0, 10
syscall
