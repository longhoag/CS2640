#MIPS Assembly Final Project 
#Caesar Cipher
#Group: Bill Cipher 
# Member: Long Hoang, Alvaro Miranda, Connor McCarry
# CS 2640.04

#github project link: https://github.com/longhoag/CS2640/blob/main/caesar_cipher.asm

# December 3, 2023


#print string macro
.macro printString(%strings)
	.data 
	string: .asciiz %strings
	
	.text
	li $v0, 4
	la $a0, string
	syscall
.end_macro

.macro getTextToProcess
	#read the user input
	la $a0, buffer
	la $a1, 40 # read 40 charaters
	li $v0, 8
	syscall
	
	la $t1, ($a0)
	li $t2, 0 # string length
	
	#read the key
	printString("\nEnter the key value: ")
	li $v0, 5
	syscall
	#store key value
	move $t3, $v0
	
	printString("\nOutput message is: ")
.end_macro 



.macro printChar
 	li $v0,11 			
 	syscall
 	
 	#point to the next char
 	add $t1, $t1,1 	
 	
 	#increment length		
 	add $t2, $t2,1 
.end_macro 

.data

buffer: .space 20
buff: .space 40

.text

main:

#t0: load option E,D
#t1: entered string
#t2: string length
#t3: key value
#t4 : letter to decode, encode
#t5: balance value ~ 26
#t8: classify value


init:
	#Encryption or Decryption 
	printString("Choose your service\nEncrypt(E) or Decrypt(D): ")
	
	#read the user input
	la $a0, buffer
	la $a1, 5 # read 5 charaters
	li $v0, 8
	syscall
	
	lb $t0, 0($a0) #load the letter
	
	# for option E
	beq $t0, 69, EncryptProcess
	#for option D
	beq $t0, 68, DecryptProcess
	#Invalid keyword --> reprompt
	printString("\nInvalid Input. Please re-enter: \n")
	j init
	
EncryptProcess:
	printString("\nEnter Text to encode: ")
	
	getTextToProcess
	
	j loadingChar

loadingChar:
	#load each charater
	lb $t4, 0($t1)
	beq $t4, 10, exit #exit if reaches the end (\n)
	beqz $t4, exit #exit if reaches the end
	
	j checkLower 
	
DecryptProcess:
	printString("\nEnter Text to decode: ")
	
	getTextToProcess
	
	j loadingChar
	
#Classify section
checkLower:
	#if the character is not lower case nor upper case
	bgt $t4, 122, notLowerUpper 
	#if the character is not lower case 
 	blt $t4, 97, notLower 
 	
 	li $t8, 1  #store value 1 in register t8 if lower case
 	
 	j classify
 
notLowerUpper:
	li $t8, 2 #store value 2 in register t8 if not lower nor upper case
	
	j classify
	
notLower:
	#if the character is not lower nor upper case
	blt $t4, 65, notLowerUpper
	#if the character is not lower nor upper case
 	bgt $t4, 91, notLowerUpper 
 	
 	#store value 0 in register t8 if the character is upper case	
 	li $t8, 0		
 	
 	j classify
 	
classify:
	beq $t8, 1, isLower #--> classify lowercase
	beq $t8, 0, isUpper #--> classify uppercase
	move $a0, $t4 #if not upper nor lower
	j printCrypt

isLower:
	# for E
	beq $t0, 69, encryptLower
	#for D
	beq $t0, 68, decryptLower

isUpper:

	# for option E
	beq $t0, 69, encryptUpper
	#for option D
	beq $t0, 68, decryptUpper


#Encryption process
encryptLower:
	#encrypt lower case: ch = (ch - 'a' + key + 26) % 26 + 'a';
	li $t5, 26   				
	sub $t4, $t4, 97 #ch - 'a'
 	add $t4, $t4, $t3 # + key
 	add $t4, $t4, $t5 # + 26
 	div $t4, $t5 # %26
 	mfhi $a0
 	
 	addi $a0, $a0, 97 # + 'a'
 	j printCrypt
 
encryptUpper:
	#encrypt lower case: ch = (ch - 'A' + key + 26) % 26 + 'A';
 	li $t5, 26   				
 	sub $t4, $t4, 65 # ch - 'A'
 	add $t4, $t4, $t3 # + key
 	add $t4, $t4, $t5 # + 26
 	div $t4, $t5 # %26
 	mfhi $a0
 	addi $a0, $a0, 65 # + 'A'
 	j printCrypt
 	

#Decryption process:
decryptLower:
	#decrypt lower case: ch = (ch - 'a' - key + 26) % 26 + 'a';
	li $t5, 26   				
 	sub $t4, $t4, 97 #ch - 'a'
 	sub $t4, $t4, $t3 # - key
 	add $t4, $t4, $t5 # + 26
 	div $t4, $t5 # % 26
 	mfhi $a0

 	addi $a0, $a0, 97 # + 'a'
 	
 	j printCrypt
 	
decryptUpper:
	#decrypt upper case: ch = (ch - 'A' - key + 26) % 26 + 'A';
	li $t5, 26   				
 	sub $t4, $t4, 65 #ch - 'A'
 	sub $t4, $t4, $t3 # - key
 	add $t4, $t4, $t5 # + 26
 	div $t4, $t5 # % 26
 	mfhi $a0
 	
 	addi $a0, $a0, 65 # + 'A'

 	j printCrypt


printCrypt:
	printChar
 	j loadingChar

exit:
	printString("\n")
	li $v0, 10
	syscall
	
