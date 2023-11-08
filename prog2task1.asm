#print string macro
.macro printString(%strings)
	.data 
	string: .asciiz %strings
	
	.text
	li $v0, 4
	la $a0, string
	syscall
.end_macro

#grading macro 
.macro gradingPrint

	printString("\n---------------------------------\n")
	printString("Would you like to enter a new score? \n (Y) Yes   (N) No\n")
	j rePrompt
.end_macro

.data

buffer: .space 20

.text
main:

printString("------------MAIN MENU------------\n")


#menu options
menu:
	printString("(1) Get Letter Grade\n")
	printString("(2) Exit Program\n")
	printString("Please enter '1' or '2' for your selection: ")

	#read the input from user
	li $v0, 5
	syscall

	move $t0, $v0 #store user option in t0
	
	#Option 1: get letter grade
	beq $t0, 1, getGrade

	#Option 2: exit
	beq $t0, 2, exit

	j menu

getGrade:
	printString("\n---------------------------------\n")
	printString("Please enter a score as an integer value: ")
	
	#read the input from user
	li $v0, 5
	syscall
	
	move $t1, $v0 #store score in t1
	
	# if the input score < 0, re prompt, not exit and display error
	blt $t1, 0, getGrade
	
	#if input score > 100, re prompt
	bgt $t1, 100, getGrade
	
	
	#Option F: 0 - 59
	ble $t1, 59, Fgrade
	
	ble $t1, 69, Dgrade
	
	ble $t1, 79, Cgrade
	
	ble $t1, 89, Bgrade
	
	ble $t1, 100, Agrade
	

# i dont need the lower bound because it will go from bottom to the top, sequentially
Fgrade:
	printString("\nThe grade is: F")
	gradingPrint
	
Dgrade:
	printString("\nThe grade is: D")
	gradingPrint
	
Cgrade:
	printString("\nThe grade is: C")
	gradingPrint
	
Bgrade:
	printString("\nThe grade is: B")
	gradingPrint
	
Agrade:
	printString("\nThe grade is: A")
	gradingPrint
	

					
rePrompt:
	printString("Please enter 'Y' or 'N' for your selection: ")
	la $a0, buffer
 	la $a1, 5
 	li $v0, 8
 	syscall 
 	
 	lb $t2, 0($a0) #store answer in t2
 
 	beq $t2, 89, Yes
 	beq $t2, 78, No
 	
 	j rePrompt
 
 Yes:
 	j getGrade
 
 No:
 	j exit
	

#exit label
exit:
printString("The program will now finish running!")
li $v0, 10
syscall
