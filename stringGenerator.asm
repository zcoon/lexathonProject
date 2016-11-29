#String Generator
#This will create an eight letter string that we will use for our border letters
.data

startingStringGen: .asciiz "\nStarting StringGen\n"
goodbye: .asciiz "\n Terminating"
resultsFromGetVowel: .asciiz "\nThe result from getVowel is: "
exitLoopStatement: .asciiz "Done with the loop -- Back in main"
loopNumberStatement: .asciiz "This is loop number: "
randomNumberStatement: .asciiz " The random int is: "
letterStatement: .asciiz " The letter is: "
newLine: .asciiz "\n"
getLetterStatement: .asciiz " In getLetter "
inModValueOne: .asciiz "In modValue One"
inModValueTwo: .asciiz "In modValue Two"
inModValueThree: .asciiz "In modValue Three"

## LETTERS ##
letterA: .byte 'a'
letterB: .byte 'b'
letterC: .byte 'c'
letterD: .byte 'd'
letterE: .byte 'e'
letterF: .byte 'f'
letterG: .byte 'a'
letterH: .byte 'a'
letterI: .byte 'i'
letterJ: .byte 'j'
letterK: .byte 'k'
letterL: .byte 'l'
letterM: .byte 'm'
letterN: .byte 'n'
letterO: .byte 'o'
letterP: .byte 'p'
letterQ: .byte 'q'
letterR: .byte 'r'
letterS: .byte 's'
letterT: .byte 't'
letterU: .byte 'u'
letterV: .byte 'v'
letterW: .byte 'w'
letterX: .byte 'x'
letterY: .byte 'y'
letterZ: .byte 'z'

.text

#main:
	li $v0, 4
	la $a0, startingStringGen
	syscall
	
	add $t0, $0, $0 # Set $t0 to zero. This will be our counter
	
	#addi $sp, $sp, -8   #make room on the stack
   	#sw  $ra, -4($sp)  
   	
   	
	jal loop
	add $t0, $0, $0 # Set $t0 to zero. This will be our counter
	jal loop
	add $t0, $0, $0 # Set $t0 to zero. This will be our counter
	jal loop
	
	li $v0, 4
	la $a0, exitLoopStatement
	syscall
	
	li $v0, 10
	syscall
	
loop: 
        addi $sp, $sp, -12   # make room on the stack
   	sw  $ra, -8($sp)     # store the address
   	
   	bgt $t0,0, exit # If $t0 is greater than 2, branch to exit
    	addi $t0,$t0,1 # Add one to the value of $t0
    	
    	li $v0, 4
    	la $a0, loopNumberStatement # Prints "This is loop number : 
    	syscall
    
    	move $a0, $t0
    	li $v0, 1 		# Prints the actual loop number
    	syscall
    
    ## Perform work here ##
    
   	li   $v0, 41       	# get a random integer
	syscall
	
	divu $t2, $a0, 3  	# mod the value in $a0 by 26 and store in $t2 so we can generate a letter number
	mfhi $v0		# Get the remainder value
	addi $v0, $v0, 1	# add 1 to modValue to make numbers match those of the alphabet
	move $s0, $v0 		# move the mod value to $s0 to use elsewhere
	
	li $v0, 4
	la $a0, randomNumberStatement # Print "The random number is: "
	syscall
	
	move $a0, $s0
	li $v0, 1	# Print the actual random number
	syscall 
	
	move $a0, $s0
	jal getLetter
	
	li $v0, 4
	la $a0, letterStatement
	syscall
	
	li $v0, 11
	la $a0, ($v1) # Actually prints the result from getLetter, which should be a letter of the alphabet
	syscall
	
	li $v0, 4
    	la $a0, newLine 	# Prints a new line
    	syscall
  	
    	j loop  

exit:
	lw  $ra, 4($sp) # lw  $ra, 4($sp) works with the following setup at the top of the loop function :
	#
	#
	# addi $sp, $sp, -12   #make room on the stack
   	# sw  $ra, -8($sp)     # store the address
   	# bgt $t0,0, exit # If $t0 is greater than 2, branch to exit
	#
	#
	jr $ra # return us to the caller, which brings us back to main
	
getLetter:
	#a0 holds the mod value, which should be 1 through 26 to be mapped to a letter of the alphabet

	beq $a0, 1 modValueOne #branch if $s0 == 1
	beq $a0, 2 modValueTwo #branch if $s0 == 2
	beq $a0, 3 modValueThree #branch if $s0 == 3
	
	jr $ra

modValueOne:
	li $v0, 4
	la $a0, inModValueOne #Log Statement
	syscall
	
	la $a0, letterA  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	
	jr $ra
	
modValueTwo:
	li $v0, 4
	la $a0, inModValueTwo #Log Statement
	syscall
	
	la $a0, letterB  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	
	jr $ra
	
modValueThree:
	li $v0, 4
	la $a0, inModValueThree #Log Statement
	syscall
	
	la $a0, letterC  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	
	jr $ra
	
