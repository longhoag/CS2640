#write a program that takes 2 numbers from users 
#have the user select from an output menu of 4 arithmetic options 
#display the result in the output to the user 


#- create and display prompt
# - store the varibales in register $t0, $t1

# - create and display 4 arithmetic options 
# - get the results 
# - store in $t2


.data
prompt1: .asciiz "Please enter the first int: "
prompt2: .asciiz "Please enter the second int: "
prompt3: .asciiz "Arithmetic Options : \n1) Add \n2) Sub \n3) Mul \n4) Div \n Please enter the corresponding int: "



.text
main:

#display prompt
li $v0, 4 # hey i want to print the string 
la $a0, prompt1 #hey print the string at this address
syscall 

#get the first int
li $v0, 5
syscall
move $t0, $v0

#same with second
li $v0, 4
la $a0, prompt2
syscall 

li $v0, 5
syscall
move $t1, $v0

#promt3
li $v0, 4
la $a0, prompt3
syscall 
#get the opertions
li $v0, 5
syscall
move $t4, $v0

#check conditions
#1 - add
#...
beq $t4, 1, addition

addition:
	#add 
	add $t2, $t0, $t1
	
	li $v0, 1
	la $a0, $t2
	syscall
	
	j exit
	
exit:
	li $v0, 10
	syscall
	
	
	


