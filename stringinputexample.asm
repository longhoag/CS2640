
.data 
prompt: .asciiz "Give me a string "
buffer: .space 25

.text
main:

li $v0, 4
la $a0, prompt 
syscall

#get user string 
li $v0, 8
la $a0, buffer #load address of 'buffer' into $a0
li $a1, 24 #24 characrers read by syscall
syscall

#print
li $v0, 4
la $a0, buffer
syscall

#exit
#li $v0, 10
#syscall