
.data
inputFileName: .asciiz "practiceFile.txt"


buffer: .space 256

.text
main:

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
	li $a2, 254
	syscall

	# print out to user 
	li $v0, 4
	la $a0, buffer 
	syscall

	# close input file
	li $v0, 16
	move $a0, $s0
	syscall
	
	j exit


# exit
exit:
li $v0, 10
syscall

