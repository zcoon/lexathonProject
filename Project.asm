# project

.data

inputString: .space 10 #max length of string input 9 bytes with newline

.text
.globl main
.include "keyGenerator.asm"
.include "letterGen.asm"
.include "timer.asm"
.include "ProjectText.asm"
.include "writeToDuplicateFile.asm"

main:
	jal keyGenerator
	
	li $v0, 10
	syscall