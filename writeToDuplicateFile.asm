.data
	userWord: .asciiz "imitation"
	duplicateFile: .asciiz "/Users/zacharyc/Desktop/duplicateFile.txt"      # filename for input
	newerLine: .asciiz "\n"
	nullTerminator: .asciiz " "
	buffer: .space 2000	
.text
writeWordToDuplicateFile:
	lb $t1, nullTerminator
do:    	lb $t2, userWord($t0)
	beq $t2, $t1, endWhile     #calculates the length of userWord and stores it in $t0	
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
    	la $a1, userWord
    	
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
    	la $a1, newerLine		#with a newline after it
    	li $a2, 1  
    	syscall

    	li $v0, 16  # $a0 already has the file descriptor. Closes the file 	
endWriteWordToDuplicateFile:
	jr $ra
