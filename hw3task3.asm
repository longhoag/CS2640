#Long Hoang (Individual)

#github project link: https://github.com/longhoag/CS2640/blob/main/hw3task3.asm

# CS 2640.04
#Assingment prompt: The prompt was posted on canvas. I'm doing the Program 3: Accessing Memory and File Handling
#Task 3: Append to File + Bonus task
# December 3, 2023

#disclaimer: i manage to write to the output file. However, you can only see it when you open in preview or export as pdf. I'm using a Mac, maybe it's the OS bugs. But I believe it works fine.

#print string macro
.macro printString(%strings)
	.data 
	string: .asciiz %strings
	
	.text
	li $v0, 4
	la $a0, string
	syscall
.end_macro

#take user input string
.macro getInput(%location)
	.data 
	buffer: .space 256 #in case their reply is long
	.text

	li $v0, 8
	la $a0, buffer #load address of 'buffer' into $a0
	li $a1, 255  #128 characrers read by syscall
	syscall
	
	move %location, $a0 #store string in t0
.end_macro

.macro write_file(%content, %memory)
	li $v0, 15
	move $a0, $s1
	la $a1, %content
	la $a2, %memory
	syscall
.end_macro

.data
inputFileName: .asciiz "practiceFile.txt"

buffer: .space 256
filename: .space 128

question: .asciiz "\n\nWhat have you enjoyed most about the class so far? "

.text
main:

	# INCLUDING bonus task, asking for user inputs to name the file and the file content
	
	# ask question to the user
	printString("What have you enjoyed most about the class so far? ")
	getInput($t0)

	printString("\nWhat do you want to name the output file? (Please include extension: .txt, etc. for valid input)  ")
	
	li $v0, 8
	la $a0, filename  #load address of 'filename' into $a0
	li $a1, 128  #128 characrers read by syscall
	syscall
	
newline_remove:
    	lb $t2, ($a0) #	check character until find \n
    	beq $t2, '\n', continue # if t2 == '\n' -> remove process
    	addi $a0, $a0, 1  # increment character
    	b newline_remove 
continue:
    	sb $zero, ($a0) # overwrite '\n' with 0

	printString("\nYour entered filename: ")
    	la $a0, filename # print the result for testing
    	li $v0, 4
    	syscall
    
    
	# open the file
	li $v0, 13
	la $a0, inputFileName

	li $a1, 0 #read from file
	li $a2, 0 #ignored
	syscall
	move $s0, $v0

	# read file
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 255
	syscall

	# write content to new file
	li $v0, 13
	la $a0, filename
	li $a1, 1
	li $a2, 0
	syscall
	move $s1, $v0

	# write to file with existing content
	write_file(buffer, 255)
	
	
	# write question for user to file
	write_file(question, 54)
	
	# write to user's answer
	li $v0, 15
	move $a0, $s1
	move $a1, $t0
	la $a2, 255
	syscall
	
	# close input file
	li $v0, 16
	move $a0, $s0
	syscall

	# close output file
	li $v0, 16
	move $a0, $s1
	syscall
	
	j exit

# exit
exit:
li $v0, 10
syscall
