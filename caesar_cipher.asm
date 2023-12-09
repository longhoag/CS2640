#Caesar cipher

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

# to handle the negetive value key and maintain the result for normal cases 
.macro keyFailSafe 
	# store the remainder in $t7
	move $t7, $a0
 	add $t7, $t7, $t5 # + 26 #handle the negative key case
 	div $t7, $t5 # %26 : take mod 1 more time to make the result falls within the alphabet character range
 	mfhi $a0
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
#t5: balance value 
#t6: in decrypt process
#t8: classify value
#t7 : result of mod (to fix negetive value key)


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
 	
 	#jr $ra #jump to return address
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
	#encrypt lower case: ch = (ch - 'a' + key) % 26 + 'a';
	li $t5, 26   				
	sub $t4, $t4, 97 #ch - 'a'
 	add $t4, $t4, $t3 # + key
 	div $t4, $t5 # %26
 	mfhi $a0
 	
 	keyFailSafe
 	# after the fail safe, general formula becomes --> ch = {[(ch - 'a' + key) % 26] + 26} % 26 + 'a';
 	
 	addi $a0, $a0, 97 # + 'a'
 	j printCrypt
 
encryptUpper:
#encrypt upper case: ch = (ch - 'A' + key) % 26 + 'A';
 	li $t5, 26   				
 	sub $t4, $t4, 65
 	add $t4, $t4, $t3
 	div $t4, $t5
 	mfhi $a0
 	
 	keyFailSafe
 	# after the fail safe, general formula becomes --> ch = {[(ch - 'A' + key) % 26] + 26} % 26 + 'A';
 	
 	addi $a0, $a0, 65
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
 	
 	#we don't need failsafe for decryption, because in the formula itself +26 already handled the case

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
 	
	#we don't need failsafe for decryption, because in the formula itself +26 already handled the case
 	
 	addi $a0, $a0, 65 # + 'A'

 	j printCrypt


printCrypt:
	printChar
 	j loadingChar

exit:
	printString("\n")
	li $v0, 10
	syscall
	
