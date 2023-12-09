.data

.text
main:
li $t4, 25
li $t5, 26
#addi $t4, $zero, -3
div $t4, $t5 # %26
mfhi $a0
#mflo $a0

li $v0, 1
syscall
