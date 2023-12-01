.data

.text
main:


# get user int
li $v0, 5
syscall
move $s0, $v0
move $t0, $s0


# base case
beq $s0, 0, baseCase
beq $s0, 1, baseCase
# recursive factorial 
# n * (n-1)
sub $s1, $s0, 1
mul $t0, $t0, $s1
beq $s1, 1, continue

j factorial

baseCase:
# print base 
li $v0, 4
la $a0, base
syscall

continue:
li $v0, 4
la $a0, resultString
syscall
# print out factorial 
li $v0, 1
move $a0, $t0
syscall

# exit
li $v0, 10
syscall
