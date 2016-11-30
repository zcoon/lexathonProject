# project

.data

inputString: .space 10 #max length of string input 9 bytes with newline
backInMain: .asciiz "\nBack in main\n"
printingGridWord: .asciiz "\n Printing Grid word \n"

.text
.globl main
.include "keyGenerator.asm"
.include "letterGen.asm"
.include "timer.asm"
.include "ProjectText.asm"
.include "writeToDuplicateFile.asm"



main:
	jal startScreen
	
	li $v0, 4
	la $a0, backInMain
	syscall 

	li $v0, 4
	la $a0, printingGridWord
	syscall 

	
	li $v0, 10
	syscall
	
	