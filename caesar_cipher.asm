.data

prompt1: .asciiz "Please enter the code: "
prompt2: .asciiz "Please enter the key: "

buffer: .space 256

.text

main:
#prompt user for code
li $v0, 4 
la $a0, prompt1
syscall 

#get string and store it in $s0
li $v0, 8
la $a0, buffer #load byte space into address
li $a1, 256 # allot byte space for input
#move $s0, $a0 #save to $s0
la $t0, ($a0) #store string in t0
li $t1, 0 #string length
syscall

#prompt for key
li $v0, 4
la $a0, prompt2
syscall 

#get the int and store it in $s1
li $v0, 5
syscall
move $s1, $v0


#output TESTING
la $a0, buffer #reload byte space 
move $a0, $t0 #primary address = t0 address
li $v0, 4 #print string 
syscall 

#Encryption:
Encrypt:
	lb $t2, 0($t0) #first character is read and load into t2
	beq $t2, 10, exit #exit if reach \n
	beqz $t2, exit #exit if reach the end 
	jal islower
	
encrypting:
	beq $v0, 1, enlower 
	beq $v0, 0, enupper
	#beq $v0, 2, printen
	move $a0, $t2 #if the character is not upper or lower


islower:
	bgt $t2, 122, notlowerupper #not lower or upper
	blt $t2, 97, notlower #not lower
	li $v0, 1 # store value 1 in register V0 if the character is a lower case character
	jr $ra #return back to the return address 
	
notlowerupper:
	li $v0, 2 # store value 2 in register VO if the character is not lower or upper
	j encrypting
	
notlower:
	blt $t2, 65, notlowerupper		# if the character is not upper or lower
 	bgt $t2, 91, notlowerupper 		# if character is not upper or lower
 	li $v0, 0   				# store value 0 in register V0 if the character is upper case
 	j encrypting
	

enlower:
	li $t3, 26
	sub $t2, $t2, 97
	add $t2, $t2, $s1
	div $t2, $t3
	mfhi $a0
	addi $a0, $a0, 97
	j printen

enupper:
	li $t3, 26
	sub $t2, $t2, 65
	add $t2, $t2, $s1
	div $t2, $t3
	mfhi $a0
	addi $a0, $a0, 65
	j printen
	

printen:
	li $v0, 11 #print character
	syscall
	add $t0, $t0, 1
	add $t1, $t1, 1
	j Encrypt
	


#exit syscall
exit:
	li $v0, 10
	syscall 