
.data
line: .asciiz "hello\n"

.text
main:

#print hello to user
li $v0, 4
la $a0, line
syscall


#print the integer 42
li $v0, 1
la $a0, 42
syscall

#exit the program
li $v0, 10
syscall 