#Long Hoang (Individual)

#github project link: https://github.com/longhoag/CS2640/blob/main/hwprogram1.asm

# CS 2640.04
#Assingment prompt: The prompt was posted on canvas. I'm doing the program 1: Getting Familiar with Assembly
# October 27, 2023

.data
prompt1: .asciiz "Please enter the 1st interger: "
prompt2: .asciiz "Please enter the 2nd interger: "

output1: .asciiz "The entered intergers are: "

comma: .asciiz ", "

aoutput: .asciiz "\n\nResult of addition: "
soutput: .asciiz "\nResult of substraction (second int - first int): "
moutput: .asciiz "\nResult of multiplication: "
doutput: .asciiz "\nResult of division (second int / first int): "

eoutput: .asciiz "\n\nUser inputs are the same\n"
noutput: .asciiz "\n\nUser inputs are different\n"

.text
main:

#TASK 1

#print the prompt to user
li $v0, 4 
la $a0, prompt1
syscall 

#get the first int and store it in $s0
li $v0, 5
syscall

move $s0, $v0


#print the prompt to user
li $v0, 4
la $a0, prompt2
syscall 

#get the second int and store it in $s1
li $v0, 5
syscall
move $s1, $v0

#print the user inputs to i/o
li $v0, 4
la $a0, output1
syscall

li $v0, 1
move $a0, $s0
syscall

li $v0, 4
la $a0, comma
syscall

li $v0, 1
move $a0, $s1
syscall

#TASK 2

#addition
li $v0, 4
la $a0, aoutput
syscall 

add $t0, $s1, $s0

li $v0, 1
move $a0, $t0
syscall


#substraction
li $v0, 4
la $a0, soutput
syscall 

sub $t0, $s1, $s0

li $v0, 1
move $a0, $t0
syscall

#multiplication
li $v0, 4
la $a0, moutput
syscall 

mul $t0, $s1, $s0

li $v0, 1
move $a0, $t0
syscall

#division
li $v0, 4
la $a0, doutput
syscall 

div $t0, $s1, $s0

li $v0, 1
move $a0, $t0
syscall


#TASK 3

#go to equality if the same
beq $s0, $s1, equality

#else go to diff
j diff


equality:
	#same number 
	li $v0, 4
	la $a0, eoutput
	syscall
	
	j exit

	
diff:
	#different number 
	li $v0, 4
	la $a0, noutput
	syscall
	
	j exit

#exit syscall
exit:
	li $v0, 10
	syscall 







