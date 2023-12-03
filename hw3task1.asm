#print string macro
.macro printString(%strings)
	.data 
	string: .asciiz %strings
	
	.text
	li $v0, 4
	la $a0, string
	syscall
.end_macro

#print int macro
.macro printInt(%int)
    	li $v0, 1
    	move $a0, %int
    	syscall
.end_macro

.macro advance 
	#advance base address to get to next element
    	addi $s0, $s0, 4
    
    	#counter++
    	addi $t1, $t1, 1
    
    	j loop
.end_macro

.data

scores: .word 32, 56, 78, 66, 88, 90, 93, 100, 101, 82

.text
main:
	#load base address of array
    	la $s0, scores
    
   	#initialize counter ($t1)
   	li $t1, 0


loop:
	#condition to exit loop
    	beq $t1, 10, exit   #if counter reaches 10 (length), then exit
    
    	#load current array element in to $t0
    	lb  $t0, 0($s0)
    
    	#grading prompt
    	printString("\nThe grade for ")
    	#print out the current int
    	printInt($t0)
    	printString(" is : ")
    	

	#if input score > 100, A with extra credit (as listed in requirement of the prompt)
	bgt $t0, 100, extraGrade
	
	
	#Option F: 0 - 59
	ble $t0, 59, Fgrade
	
	#Option D: 60 - 69
	ble $t0, 69, Dgrade
	
	#Option C: 70 - 79
	ble $t0, 79, Cgrade
	
	#Option B: 80 - 89
	ble $t0, 89, Bgrade
	
	#Option A: 90 - 100
	ble $t0, 100, Agrade
	

# i dont need the lower bound because it will go from bottom to the top, sequentially
Fgrade:
	printString("F")
	advance
	
extraGrade:
	printString("A with Extra Credit")
	advance
	
Dgrade:
	printString("D")
	advance
	
Cgrade:
	printString("C")
	advance
	
Bgrade:
	printString("B")
	advance
	
Agrade:
	printString("A")
	advance
    

#exit label
exit:
printString("\nGraded by Long Hoang!")
printString("\nThe program will now exit.")
li $v0, 10
syscall