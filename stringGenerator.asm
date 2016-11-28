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
	
getLetter:
	#a0 holds the mod value, which is 1, 2, 3, 4 or 5 to be mapped to a variable

	beq $a0, 1 modValueOne #branch if $s0 == 1
	beq $a0, 2 modValueTwo #branch if $s0 == 2
	beq $a0, 3 modValueThree #branch if $s0 == 3
	beq $a0, 4 modValueFour #branch if $s0 == 4
	beq $a0, 5 modValueFive #branch if $s0 == 5
	beq $a0, 6 modValueSix #branch if $s0 == 1
	beq $a0, 7 modValueSeven #branch if $s0 == 2
	beq $a0, 8 modValueEight #branch if $s0 == 3
	beq $a0, 9 modValueNine #branch if $s0 == 4
	beq $a0, 10 modValueTen #branch if $s0 == 5
	beq $a0, 11 modValueEleven #branch if $s0 == 1
	beq $a0, 12 modValueTwelve #branch if $s0 == 2
	beq $a0, 13 modValueThirteen #branch if $s0 == 3
	beq $a0, 14 modValueFourteen #branch if $s0 == 4
	beq $a0, 15 modValueFifteen #branch if $s0 == 5
	beq $a0, 16 modValueSixteen #branch if $s0 == 1
	beq $a0, 17 modValueSeventeen #branch if $s0 == 2
	beq $a0, 18 modValueEighteen #branch if $s0 == 3
	beq $a0, 19 modValueNineteen #branch if $s0 == 4
	beq $a0, 20 modValueTwenty #branch if $s0 == 5
	beq $a0, 21 modValueTwentyOne #branch if $s0 == 1
	beq $a0, 22 modValueTwentyTwo #branch if $s0 == 2
	beq $a0, 23 modValueTwentyThree #branch if $s0 == 3
	beq $a0, 24 modValueTwentyFour #branch if $s0 == 4
	beq $a0, 25 modValueTwentyFive #branch if $s0 == 5
	beq $a0, 26 modValueTwentySix #branch if $s0 == 5
	
	jr $ra

