.data
	goodInput: 		.asciiz "Good job"
	inputBad:		.asciiz "Invalid Entry, Please Try Again!\n"
	userWord: 		.asciiz "ofx"
	nullSpace:		.asciiz ""
	gridArray: 		.ascii "fox"
.text
wordGridCheck:
	lb $t4, nullSpace 
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
	addi $v0, $v0, 0 
	li $v0, 4
	la $a0, inputBad
	syscall
	
	j gridDone
gridChecked:
	addi $v0, $v0, 1 
	li $v0, 4
	la $a0, goodInput
	syscall
	
	j gridDone
gridDone:
	
      
        
        




