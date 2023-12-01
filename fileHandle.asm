.data

inputFileName: .asciiz "gradedItems.txt"
outputFileName: .asciiz "outputFile.txt"
buffer: .space 175

.text
main:
#open the file
li $v0, 13
la $a0, inputFileName

li $a1, 0 #read from file
li $a2, 0 #ignored
syscall
move $s0, $v0

#read file
li $v0, 14
move $a0, $s0
la $a1, buffer
li $a2, 174
syscall

#print out to user 
li $v0, 4
la $a0, buffer 
syscall

#write content to new file
li $v0, 13
la $a0, outputFileName
li $a1, 1
li $a2, 0
syscall
move $s1, $v0

#write to file
li $v0, 15
move $a0, $s1
la $a1, buffer
la $a2, 174
syscall

# exit
li $v0, 16
move $a0, $s0
syscall

# close output file
li $v0, 16
move $a0, $s1
syscall

