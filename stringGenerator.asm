#String Generator
#This will create an eight letter string that we will use for our border letters
.data

startingStringGen: .asciiz "\nStarting StringGen\n"
goodbye: .asciiz "\n Terminating"
resultsFromGetVowel: .asciiz "\nThe result from getVowel is: "
exitLoopStatement: .asciiz "Done with the loop -- Back in main"
loopNumberStatement: .asciiz "This is loop number: "
randomNumberStatement: .asciiz " The random int is: "
newLine: .asciiz "\n"

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

main:
	li $v0, 4
	la $a0, startingStringGen
	syscall
	
	add $t0, $0, $0 # Set $t0 to zero. This will be our counter
	jal loop
	
	li $v0, 4
	la $a0, exitLoopStatement
	syscall
	
	li $v0, 10
	syscall
	
loop: 
   	bgt $t0,7, exit # If $t0 is greater than 7, branch to exit
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
	
	divu $t2, $a0, 26  	# mod the value in $a0 by 26 and store in $t2 so we can generate a letter number
	mfhi $v0		# Get the remainder value
	addi $v0, $v0, 1	# add 1 to modValue to handle case where the div operation results in 0
	move $s0, $v0 		# move the mod value to $s0 to use elsewhere
	
	li $v0, 4
	la $a0, randomNumberStatement # Print "The random number is: "
	syscall
	
	move $a0, $s0
	li $v0, 1	# Print the actual random number
	syscall 
	
	li $v0, 4
    	la $a0, newLine 	# Prints a new line
    	syscall
    	j loop  

exit:
	jr $ra # return us to the caller, which brings us back to main
	

