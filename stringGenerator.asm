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
inModValueOne: .asciiz " In modValue One"
inModValueTwo: .asciiz " In modValue Two"
inModValueThree: .asciiz " In modValue Three"

## LETTERS ##
letterA: .byte 'a'
letterB: .byte 'b'
letterC: .byte 'c'
letterD: .byte 'd'
letterE: .byte 'e'
letterF: .byte 'f'
letterG: .byte 'g'
letterH: .byte 'h'
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



	#addi $sp, $sp, -8   #make room on the stack
   	#sw  $ra, -4($sp)


  #t0 must be set to zero each time because we use a for loop with max value of zero in "loop"
	 	
  add $t0, $0, $0 # Set $t0 to zero. This will be our counter
	jal loop
	add $t0, $0, $0 # Set $t0 to zero. This will be our counter
	jal loop
	add $t0, $0, $0 # Set $t0 to zero. This will be our counter
	jal loop
	add $t0, $0, $0 # Set $t0 to zero. This will be our counter
	jal loop
	add $t0, $0, $0 # Set $t0 to zero. This will be our counter
	jal loop
	add $t0, $0, $0 # Set $t0 to zero. This will be our counter
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

    	#li $v0, 4
    	#la $a0, loopNumberStatement # Prints "This is loop number :
    	#syscall

    	#move $a0, $t0
    	#li $v0, 1 		# Prints the actual loop number
    	#syscall

    ## Perform work here ##

   	li   $v0, 41       	# get a random integer
	syscall

	divu $t2, $a0, 26  	# mod the value in $a0 by 26 and store in $t2 so we can generate a letter number
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
	beq $a0, 4 modValueFour #branch if $s0 == 4
	beq $a0, 5 modValueFive #branch if $s0 == 5
	beq $a0, 6 modValueSix #branch if $s0 == 6
	beq $a0, 7 modValueSeven #branch if $s0 == 7
	beq $a0, 8 modValueEight #branch if $s0 == 8
	beq $a0, 9 modValueNine #branch if $s0 == 9
	beq $a0, 10 modValueTen #branch if $s0 == 10
	beq $a0, 11 modValueEleven #branch if $s0 == 11
	beq $a0, 12 modValueTwelve #branch if $s0 == 12
	beq $a0, 13 modValueThirteen #branch if $s0 == 13
	beq $a0, 14 modValueFourteen #branch if $s0 == 14
	beq $a0, 15 modValueFifteen #branch if $s0 == 15
	beq $a0, 16 modValueSixteen #branch if $s0 == 16
	beq $a0, 17 modValueSeventeen #branch if $s0 == 17
	beq $a0, 18 modValueEighteen #branch if $s0 == 18
	beq $a0, 19 modValueNineteen #branch if $s0 == 19
	beq $a0, 20 modValueTwenty #branch if $s0 == 20
	beq $a0, 21 modValueTwentyOne #branch if $s0 == 21
	beq $a0, 22 modValueTwentyTwo #branch if $s0 == 22
	beq $a0, 23 modValueTwentyThree #branch if $s0 == 23
	beq $a0, 24 modValueTwentyFour #branch if $s0 == 24
	beq $a0, 25 modValueTwentyFive #branch if $s0 == 25
	beq $a0, 26 modValueTwentySix #branch if $s0 == 26

	jr $ra

modValueOne:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterA  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueTwo:
	#li $v0, 4
	#la $a0, inModValueTwo #Log Statement
	#syscall

	la $a0, letterB  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueThree:
	#li $v0, 4
	#la $a0, inModValueThree #Log Statement
	#syscall

	la $a0, letterC  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueFour:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterD  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueFive:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterE  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueSix:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterF  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueSeven:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterG  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueEight:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterH  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueNine:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterI  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueTen:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterJ  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueEleven:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterK  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueTwelve:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterL  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueThirteen:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterM  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueFourteen:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterN  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueFifteen:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterO  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueSixteen:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterP  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueSeventeen:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterQ  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueEighteen:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterR  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueNineteen:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterS  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueTwenty:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterT  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueTwentyOne:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterU  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueTwentyTwo:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterV  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueTwentyThree:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterW  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueTwentyFour:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterX  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra

modValueTwentyFive:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterY  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra


modValueTwentySix:
	#li $v0, 4
	#la $a0, inModValueOne #Log Statement
	#syscall

	la $a0, letterZ  # Get the address
	lb $v1, ($a0)  # Get the value at that address

	jr $ra
