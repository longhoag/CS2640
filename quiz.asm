

.data
prompt: .asciiz "Please enter one interger: "

output: .asciiz "The entered interger is: "

.text
main:

#print the prompt to user
li $v0, 4 
la $a0, prompt
syscall 

#get the first int
li $v0, 5
syscall

move $s0, $v0

#print out to user
li $v0, 4
la $a0, output
syscall

li $v0, 1
move $a0, $s0
syscall

li $v0, 10
syscall 
