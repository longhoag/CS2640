# CS 2640.04

#OCtober 9, 2023
# A simple program in the style of "hello world"

.data
message: .asciiz "programming in assembly"


.text
main:
# print the string 
li $s0, f	#telling tehe asembler we will print a string
li $s1, g
li $s2, h
li $s3, i
li $s4, j

add $t0, $s1, $s2
sub $t1, $s3, $s4
sub $s0, $t0, $t1



la $a0, message #get the location of 'message' and store in $a0 
syscall # has the assembler print the string 

#exit program 
li $v0, 10	#tells the assembler that we exit program after running 
syscall # has the assembler exit the program