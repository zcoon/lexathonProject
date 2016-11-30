.data
	#main.asm strings
	gameObjective: 		.asciiz "	The object of the game is to find as many possible word combinations as you can given the letters you are provided with.\n"
	intro:			.asciiz "*********************************************************How To Play*******************************************************************\n"
	rulesOne:		.asciiz	"1. You have 60 seconds to input as many words as you can.\n"
	rulesTwo:		.asciiz "2. There is no penalty for wrong words.\n"
	rulesThree: 		.asciiz "3. Each word MUST have the key letter in the word, the key letter is located in the center of the grid.\n"
	rulesFour: 		.asciiz "4. Each word must have at least 4 different letters in it (no duplicate letters are allowed).\n"
	rulesFive:		.asciiz "5. When the 60 seconds is up the game is over or simply quit by entering 0.\n\n"
	beginGame: 		.asciiz "Enter 1 to begin the game or 0 to quit!"
	projectTextNewLine: 	.asciiz "\n"
	gameOver:		.asciiz "\n**************************************** GAME  OVER!! *************************************\n"
	scoreMessage:		.asciiz "\nTotal score: "
	missedWordsNumber:	.asciiz "Total number of missed words: "
	possibleWordsNumber:	.asciiz "\nNumber of possible words: "
	input: 			.space 9
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
	.text	
	
	#.include "letterGen.asm"
	
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
     	
     	la $a0, projectTextNewLine
     	syscall  
     	
     	la $a0, beginGame
     	syscall
     	
     	li $v0, 5
     	syscall
     	
     	move $t1, $v0
     	blt $t1, 1, gameEnd
     	bgt $t1, 1, badInput
     	
PrintGameGrid:
	li $v0, 4
	la $a0, gridPrintRow
     	syscall
	
     	la $a0, gridPrint
     	syscall   
     	
     	jal letterGen
   	sw $v0, gridWord
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
     	la $a0, gridPrint
     	syscall
     	
     	j letterGen
   	sw $v0, gridWord
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
     	la $a0, gridPrint
     	syscall
     	
     	j letterGen
   	sw $v0, gridWord
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
     	la $a0, gridPrint
     	syscall
     	
     	la $a0, projectTextNewLine
     	syscall
     	
     	la $a0, gridPrintRow
     	syscall
     	
     	la $a0, gridPrint
     	syscall   
     	
     	j letterGen
   	sw $v0, gridWord
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
     	la $a0, gridPrint
     	syscall
     	
     	j letterGen
   	sw $v0, gridWord
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
     	la $a0, gridPrint
     	syscall
     	
     	j letterGen
   	sw $v0, gridWord
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
     	la $a0, gridPrint
     	syscall
     	
     	la $a0, projectTextNewLine
     	syscall
     	
     	la $a0, gridPrintRow
     	syscall
     	
     	la $a0, gridPrint
     	syscall   
     	
     	j letterGen
   	sw $v0, gridWord
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
     	la $a0, gridPrint
     	syscall
     	
     	j letterGen
   	sw $v0, gridWord
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
     	la $a0, gridPrint
     	syscall
     	
     	j letterGen
   	sw $v0, gridWord
     	lb $a0, gridWord($t5)
     	syscall
     	
     	addi $t5, $t5, 1
     	
     	la $a0, gridPrint
     	syscall
     	
     	la $a0, projectTextNewLine
     	syscall
     	
     	la $a0, gridPrintRow
     	syscall
     	
     	li $v0, 10
	syscall
	
badInput:
	
	li $v0, 4
	la $a0, inputBad
	syscall
	
	j main
	
gameEnd:

	li $v0, 4
	la $a0, scoreMessage

	li $v0, 10
	syscall
