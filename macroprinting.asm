#1. main label
#2. printing macro
#3. loop label 
#4. exit macro

.macro printing 
	li $v0, 4
	la $a0, string
	syscall 
.end_macro

.macro exit
	li $v0, 10
	syscall	
.end_macro



.data
string: .asciiz "Hello"


.text

main:
printing

move $t0, $zero


#loop:
	#beq $t0, 5, exit
	#printing 
	#addi $t0, $t0, 1
	#j loop

.macro ints(%x)
	li $v0, 1
	add $a0, $zero, %x
	syscall
.end_macro 


.macro aString(%strings)
	li $v0, 4
	
	.data 
	userString: .asciiz %strings 
	.text
	la $a0, userString
	syscall
.end_macro


aString("heldfsdflo")


.macro macArray(%array)
	la $s0, %array
	lw $t0, 8($s0)
	add $t1, $t0, 1

.end_macro


exit