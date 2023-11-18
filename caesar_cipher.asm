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

#cua ng ta - cua minh
#t2 - t0
#t0 - t1
#t1 - t2 
#t3 - t3
#t4 - t4

init:
	#Encryption or Decryption 
	printString("Choose your service\nEncrypt(E) or Decrypt(D) ?")
	
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
	
	j encrypt

encrypt:
	#load each charater
	lb $t4, 0($t1)
	beq $t4, 10, exit #exit if reaches the end (\n)
	beqz $t4, exit #exit if reaches the end
	
	j EisLower 
	
#Encryption 
EisLower:
	#if the character is not lower case or upper case
	bgt $t4, 122, notLowerUpper 
	#if the character is not lower case 
 	blt $t4, 97, notLower 
 	
 	li $v0, 1  #store value 1 in register v0 if lower case
 	
 	jr $ra #jump to return address
 
notLowerUpper:
	li $v0, 2 #store value 2 in register v0 if not lower nor upper case
	
	
exit:
	li $v0, 10
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
