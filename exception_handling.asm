

.data
enterOne: .asciiz "Please enter the number '1': "
correct: .asciiz "That was a valid input. goodbye. "

# Trap handler in the standard MIPS32 kernel text segment

.text
main: 
# print the prompt
li $v0, 4
la $a0, enterOne
syscall

# get input
li $v0, 5
syscall
move $s0, $v0


#trap if input is not equal to 1
tnei $s0, 1

#print correct prompt
li $v0, 4
la $a0, correct 
syscall


   .ktext 0x80000180
   move $k0,$v0   # Save $v0 value
   move $k1,$a0   # Save $a0 value
   la   $a0, incorrect  # address of string to print
   li   $v0, 4    # Print String service
   syscall
   move $v0,$k0   # Restore $v0
   move $a0,$k1   # Restore $a0
   mfc0 $k0,$14   # Coprocessor 0 register $14 has address of trapping instruction
   addi $k0,$k0,4 # Add 4 to point to next instruction
   mtc0 $k0,$14   # Store new address back into $14
   eret           # Error return; set PC to value in $14
   .kdata	
   
   incorrect: .asciiz "That was an invalid input. goodbye"