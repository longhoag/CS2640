#Long Hoang

#CS2640.04
#program to loop through an array and print the elements
#$s0 for base address of array
#$t0 for current value to be printed

.data
array: .word 1, 2, 3, 4, 5
prompt1: .asciiz "Array elements: "
prompt2: .asciiz "  "

.text
main:
    #load base address of array
    la $s0, array
    
    #initialize counter ($t1)
    li $t1, 0
    
    #print the prompt
    li $v0, 4
    la $a0, prompt1
    syscall
    
loop:
    #condition to exit loop
    beq $t1, 5, exit   #if counter reaches 5, then exit
    
    #load current array element in to $t0
    lw $t0, 0($s0)
    
    #print out the current integer
    li $v0, 1
    move $a0, $t0
    syscall
    
    #space for formatting
    li $v0, 4
    la $a0, prompt2
    syscall
    
    #advance base address to get to next element
    addi $s0, $s0, 4
    
    #counter++
    addi $t1, $t1, 1
    
    j loop
    
exit:
    li $v0, 10
    syscall
