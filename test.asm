.data
	wordLength:	.word 0
	validMessage: 	.asciiz "Valid word"
	invalidMessage:	.asciiz "Invalid word"
	userWord: 	.asciiz "thxerx"
	nullterminator:	.asciiz ""
	gridArray: 	.ascii "hpry"
	duplicateFile: 	.asciiz "/Users/juangarcia/duplicateFile.txt"      # filename for input
	newline: 	.asciiz "\n"
	buffer: 	.space 50000	
.text
	lb $t4, nullterminator 
wordGridCheck: 
	lb $t0, userWord($t1)
        lb $t2, gridArray($t3)
        beq $t2, $t4, gridFail
        beq $t0, $t4, gridChecked
        bne $t2, $t0, moveGridArray
        beq $t2, $t0, moveUserArray
moveGridArray:	
	addi $t3, $t3, 1
	j wordGridCheck
moveUserArray:
	addi $t1, $t1, 1
	move $t3, $0
	j wordGridCheck
gridFail: 
	j invalidWord
gridChecked:			# word is made of letters from the grid
	j validWord
invalidWord:
	li $v0, 4
	la $a0, invalidMessage
	syscall
	j done
validWord:
	li $v0, 4
	la $a0, validMessage
	syscall
done:
