.data
buffer: .space 256 #in case their reply is long
word: .space 21
result: .asciiz " ...that's the name"
.text
main:
	li $v0, 8
	la $a0, buffer #load address of 'buffer' into $a0
	li $a1, 50  #50 characrers read by syscall
	syscall
	#move $t1, $a0
	

len_to_new_line:
    lb $t2, ($a0) # t2 = *a0
    beq $t2, '\n', end # if t2 == '\n' -> stop
    addi $a0, $a0, 1 # a0++
    b len_to_new_line   
end:
    sb $zero, ($a0) # overwrite '\n' with 0

    la $a0, buffer # print the result
    li $v0, 4
    syscall

    la $a0, result
    li $v0, 4
    syscall


	
li $v0, 10
syscall