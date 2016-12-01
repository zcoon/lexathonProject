.data
	gameObjective: 		.asciiz "	The object of the game is to find as many possible word combinations as you can given the letters you are provided with.\n"
	intro:			.asciiz "*********************************************************How To Play*******************************************************************\n"
	rulesOne:		.asciiz	"1. You have 60 seconds to input as many words as you can.\n"
	rulesTwo:		.asciiz "2. There is no penalty for wrong words.\n"
	rulesThree: 		.asciiz "3. Each word MUST have the key letter in the word, the key letter is located in the center of the grid.\n"
	rulesFour: 		.asciiz "4. Each word must have at least 4 different letters in it (no duplicate letters are allowed).\n"
	rulesFive:		.asciiz "5. When the 60 seconds is up the game is over or simply quit by entering 0.\n\n"
	beginGame: 		.asciiz "Enter 1 to begin the game or 0 to quit!"
	newline: 		.asciiz "\n"
	newSpace:		.asciiz " "
	gameOver:		.asciiz "\n**************************************** GAME  OVER!! *************************************\n"
	scoreMessage:		.asciiz "\nTotal score: "
	missedWordsNumber:	.asciiz "Total number of missed words: "
	possibleWordsNumber:	.asciiz "\nNumber of possible words: "
	input: 			.space 30
	inputBad:		.asciiz "Invalid Entry, Please Try Again!\n"
	playAgainMessage:	.asciiz "\nWould you like to play again? Type '1' for Yes or '0' for No (Exit Program): "
	successMessage1: 	.asciiz "\nThe total number of correct words you enetered was: "
	duplicateMessage:	.asciiz "\nDuplicate word entered!\n"
	promptUser:		.asciiz "\nEnter your word or type '0' to Quit: "
	keyError:		.asciiz "\nYou didn's use the key letter! Try again...\n"
	gridPrint:		.asciiz "| "
	filler:			.asciiz "n "
	gridPrintRow:		.asciiz " ___ ___ ___\n"
	gridWord: 		.space 8
	keyLetter:		.space 1
	userScore:		.word 0
	userInput:		.space 9
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
	
	duplicateFile: .asciiz "/Users/juangarcia/duplicateFile.txt"
.text
startScreen:	

	li $v0, 4
     	la $a0, gameObjective
     	syscall   
    
     	la $a0, intro
     	syscall   
     	
     	la $a0, rulesOne
     	syscall   
     	
     	la $a0, rulesTwo
     	syscall   
     	
     	la $a0, rulesThree
     	syscall   
     	
     	la $a0, rulesFour
     	syscall   
     	
     	la $a0, rulesFive
     	syscall
     	
     	la $a0, newline
     	syscall  
inputPrompt:     	
     	la $a0, beginGame
     	syscall
     	
     	li $v0, 5
     	syscall
     	
     	addi $t0, $zero, 1
     	
     	beq $v0, $zero, gameEnd
     	bne $v0, $t0, badInput
     	add $t0, $zero, $zero 
     	
     	jal letterGen
     	
     	
printGameGrid:
	move $t5, $zero
	
	li $v0, 4
	la $a0, newline
	syscall
	
	la $a0, gridPrintRow
     	syscall
	
     	la $a0, gridPrint
     	syscall   
     				
	li $v0, 11
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
	li $v0, 4
	la $a0, newSpace
	syscall
	
     	la $a0, gridPrint
     	syscall
     	
   	li $v0, 11
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
	li $v0, 4
	la $a0, newSpace
	syscall
	
     	la $a0, gridPrint
     	syscall
	
     	li $v0, 11
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
	li $v0, 4
	la $a0, newSpace
	syscall
	
     	la $a0, gridPrint
     	syscall
     	
     	la $a0, newline
     	syscall
     	
     	la $a0, gridPrintRow
     	syscall
     	
     	la $a0, gridPrint
     	syscall   
     	
     	li $v0, 11
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
	li $v0, 4
	la $a0, newSpace
	syscall
	
     	la $a0, gridPrint
     	syscall
     	
    #######key letter######
   	j keyGenerator
 printKeyLetter:
     	li $v0, 11
     	lb $a0, keyLetter		
     	syscall
     	
	li $v0, 4
	la $a0, newSpace
	syscall
	
     	la $a0, gridPrint
     	syscall
     	
printGameGridHalf:
   	li $v0, 11
     	lb $a0, gridWord($t5)		
     	syscall
     	
     	addi $t5, $t5, 1
     	
	li $v0, 4
	la $a0, newSpace
	syscall
	
     	la $a0, gridPrint
     	syscall
     	
     	la $a0, newline
     	syscall
     	
     	la $a0, gridPrintRow
     	syscall
     	
     	la $a0, gridPrint
     	syscall   
     	
   	li $v0, 11
     	lb $a0, gridWord($t5)		
     	syscall
     	
     	addi $t5, $t5, 1
     	
	li $v0, 4
	la $a0, newSpace
	syscall
	
     	la $a0, gridPrint
     	syscall
     	
   	li $v0, 11
     	lb $a0, gridWord($t5)		
     	syscall
     	
     	addi $t5, $t5, 1
     	
	li $v0, 4
	la $a0, newSpace
	syscall
	
     	la $a0, gridPrint
     	syscall
     	
   	li $v0, 11
     	lb $a0, gridWord($t5)		
     	syscall
     	
	li $v0, 4
	la $a0, newSpace
	syscall
	
     	la $a0, gridPrint
     	syscall
     	
     	la $a0, newline
     	syscall
 	
     	la $a0, gridPrintRow
     	syscall
     	
     	#################### timer function can go here, start the timer
	
userInputFunction:
	li $v0, 4 
	la $a0, promptUserInput
	syscall

	 li $v0, 8
 	 la $a0, userInput
 	 li $a1, 500
 	 syscall
validateUserInput:
	j checkKey
	
     	##################### jump to the check file, to determine if the word is valid
     	
     	##################### if the word is valid
     	#jal writeWordToDuplicateFile		#causes main not to work becuase of the path name of the duplicate file
     	jal incrementScore
invalidInput:
	li $v0, 4
	la $a0, inputBad
	syscall
	
	j userInputFunction

	##################### -jump back up to the userInput function
     	
	##################### if the timer ends, the game has to end
 	
     	j inputPrompt		#this sends you back to the prompt, where you can exit or start a new game
     	
###################################################  end of main  ##################################################### 
	
badInput:
	li $v0, 4
	la $a0, inputBad
	syscall
	
	j inputPrompt
gameEnd:
	li $v0, 4
	la $a0, scoreMessage

	li $v0, 10
	syscall
keyGenerator:
	li   $v0, 41       	# get a random int
	syscall

	divu $t0, $a0, 5   	# mod it by 5 so we can generate a vowel with that vowel
	mfhi $v0		# Get the remainder value
	addi $v0, $v0, 1	# add 1 to modValue to handle case where the div operation results in 0
	move $s0, $v0 		# move the mod value to $s0

	move $a0, $s0 		# move the modValue to $a0

	jal getVowel 		# Call the function to return 1 vowel

	sb $v1, keyLetter($zero)
	j printKeyLetter

keyModValueOne:
	la $a0, letterA  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
keyModValueTwo:
	la $a0, letterE  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
keyModValueThree:
	la $a0, letterI  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
keyModValueFour:
	la $a0, letterO  # Get the address
	lb $v1, 0($a0)  # Get the value at that address
	jr $ra
keyModValueFive:
	la $a0, letterU  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
getVowel:
	#a0 holds the mod value, which is 1, 2, 3, 4 or 5 to be mapped to a variable
	beq $a0, 1 keyModValueOne #branch if $s0 == 1
	beq $a0, 2 keyModValueTwo #branch if $s0 == 2
	beq $a0, 3 keyModValueThree #branch if $s0 == 3
	beq $a0, 4 keyModValueFour #branch if $s0 == 4
	beq $a0, 5 keyModValueFive #branch if $s0 == 5

	jr $ra

letterGen:
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
loop:
        addi $sp, $sp, -12   # make room on the stack
   	sw  $ra, -8($sp)     # store the address

   	bgt $t0,0, exit # If $t0 is greater than 2, branch to exit
    	addi $t0,$t0,1 # Add one to the value of $t0

   	li   $v0, 41       	# get a random integer
	syscall

	divu $t2, $a0, 26  	# mod the value in $a0 by 26 and store in $t2 so we can generate a letter number
	mfhi $v0		# Get the remainder value
	addi $v0, $v0, 1	# add 1 to modValue to make numbers match those of the alphabet
	move $s0, $v0 		# move the mod value to $s0 to use elsewhere

	move $a0, $s0   # Move the random int to $a0 to pass to the getLetter function
	jal getLetter

	move $t7, $v1
	sb $t7, gridWord($t6)
	addi $t6, $t6, 1
    	
	beq $t6, 8, printGameGrid
	
    	j loop
exit:
	lw  $ra, 4($sp) # Do not change this or it will break
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
	la $a0, letterA  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueTwo:
	la $a0, letterB  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueThree:
	la $a0, letterC  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueFour:
	la $a0, letterD  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueFive:
	la $a0, letterE  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueSix:
	la $a0, letterF  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueSeven:
	la $a0, letterG  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueEight:
	la $a0, letterH  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueNine:
	la $a0, letterI  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueTen:
	la $a0, letterJ  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueEleven:
	la $a0, letterK  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueTwelve:
	la $a0, letterL  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueThirteen:
	la $a0, letterM  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueFourteen:
	la $a0, letterN  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueFifteen:
	la $a0, letterO  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueSixteen:
	la $a0, letterP  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueSeventeen:
	la $a0, letterQ  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueEighteen:
	la $a0, letterR  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueNineteen:
	la $a0, letterS  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueTwenty:
	la $a0, letterT  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueTwentyOne:
	la $a0, letterU  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueTwentyTwo:
	la $a0, letterV  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueTwentyThree:
	la $a0, letterW  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueTwentyFour:
	la $a0, letterX  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueTwentyFive:
	la $a0, letterY  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra
modValueTwentySix:
	la $a0, letterZ  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	jr $ra

writeWordToDuplicateFile:
do:    	lb $t2, input($t0)
	beq $t2, $zero, endWhile     #calculates the length of myword and stores it in $t0	
    	addi $t0, $t0, 1
    	j do
endWhile:		

	li $v0, 13
    	la $a0, duplicateFile	#open file for write/append
   	li $a1, 9
   	li $a2, 0
   	syscall  # File descriptor gets returned in $v0

    	move $a0, $v0  # Syscall 15 requires file descriptor in $a0
    	li $v0, 15
    	la $a1, input
    	
    	bne $t0, 4, check5
    	li $a2, 4  
    	j doneCheck
check5: bne $t0, 5, check6
    	li $a2, 5  
    	j doneCheck
check6: bne $t0, 6, check7	#These checks are necessary becuase writing to the file 
    	li $a2, 6  		#requires the hardcoded length of the word to be written
    	j doneCheck		#so we need to hardcode all 6 options
check7: bne $t0, 7, check8
    	li $a2, 7  
    	j doneCheck
check8: bne $t0, 8, check9
    	li $a2, 8  
    	j doneCheck
check9: 
    	li $a2, 9  
    	
doneCheck:
    	syscall			#word is appened to the file
    	
    	li $v0, 15
    	la $a1, newline		#with a newline after it
    	li $a2, 1  
    	syscall

    	li $v0, 16  # $a0 already has the file descriptor. Closes the file 	
endWriteWordToDuplicateFile:

incrementScore:
     lw $t0, userScore
     addi $t0, $t0, 1
     sw $t0, userScore

     j userInputFunction
