#CS2640.04
#October 20, 2023 
#Write a program in Assembly that takes two numbers from a user and outputs the greater number
#1 pronpt for inputs 
#2 assign nummbers for regiters
#3 compare numbers 
#4 output

.data 
prompt1: .asciiz "Please input 1st number: "
prompt2: .asciiz "Please input 2nd number: "
equal: .asciiz "The user inputs are equal"
first: .asciiz "The first number is greater"
second: .asciiz "The second number is greater"
.text
main:

#output the created promot1
li $v0, 4
la $a0, prompt1
syscall 

#get user number 1 
li  $v0, 5
syscall 
move $t0, $v0 

#output the created promot2
li $v0, 4
la $a0, prompt2
syscall 

#get user number 2
li  $v0, 5
syscall 
move $t1, $v0 

#compare 
beq $t0, $t1, else
bgt $t0, $t1, firstly 
blt $t0, $t1, secondly

else:
	#same number 
	li $v0, 4
	la $a0, equal
	syscall
	
	j exit
firstly:
	li $v0, 4
	la $a0, first
	syscall

	j exit
secondly:
	li $v0, 4
	la $a0, second
	syscall
	
	j exit


#exit syscall
exit:
	li $v0, 10
	syscall 
