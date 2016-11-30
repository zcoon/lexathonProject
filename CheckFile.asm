.data
	wordLength:		.word 0
	validWordMessage: 	.asciiz "Valid word"		#This will be taken out
	invalidWordMessage:	.asciiz "Invalid word"		#This will be taken out
	userWord: 		.asciiz "thxerx"
	nullterminator:		.asciiz ""
	gridArray: 		.ascii "hpry"
	duplicateFile: 		.asciiz "/Users/juangarcia/duplicateFile.txt"      # filename for input
	newline: 		.asciiz "\n"
	buffer: 		.space 50000	
.text
CheckLength:
        addi $t0, $t0, 4
        addi $t1, $t1, 9
lengthLoop:
        lb $t2, userWord($t3) # load the next character into t2
        addi $t3, $t3, 1 # increment the string pointer
        bne $t4, $t2, lengthLoop # check for the null character
        subi $t3, $t3, 1
        bgt $t3, $t1, invalidWord
        blt $t3, $t0, invalidWord
        
        sw $t3, wordLength
	add $t1, $zero, $zero
	add $t3, $zero, $zero
	
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
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero

duplicateCheck:
	# Doesnt need any arguments, just the user's word in some form (a variable 
	# like myword that i used, or in an$a register)
	lb $t1, nullterminator
	lb $t2, newline
	
	li   $v0, 13       # system call for open file
	la   $a0, duplicateFile   # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $a0, $v0

	li   $v0, 14       # system call for read from file
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 50000    # hardcoded buffer length
	syscall            # read from file
	
duplicateCheckLoop:
	lb $t3, buffer($t4)
	
	addi $t4, $t4, 1
	beq $t3, $t1, duplicateCheckEnd		#branch if it's the end of the file
	bne $t3, $t2, duplicateCheckLoop	#branch if it's not a newline
	beq $t5, $zero, firstStart
	addi $t5, $t6, 2
firstStart:
	subi $t6, $t4, 2	#$t5 to $t6 holds a word from the file
	
	addi $t6, $t6, 1
	add $t7, $t5, $zero	#set $t7 equal to $t5, to use $t7 as $t5 without altering $t5
	add $t8, $zero, $zero

duplicateDo:
	lb $s1, buffer($t7)	#letter in file word
	lb $s2, userWord($t8)	#letter in user's word
	bne $s1, $t2, noNTChange	
	move $s1, $t1		#sets file word letter to null terminator incase its newline
noNTChange:
	bne $s1, $s2, duplicateNotWord
	beq $s1, $t1, match	
	addi $t7, $t7, 1
	addi $t8, $t8, 1
	j duplicateDo
	
match:	j invalidWord
duplicateNotWord:
	subi $t6, $t6, 1

	bne $t5, $zero, duplicateCheckLoop
	addi $t5, $t6, 2
	j duplicateCheckLoop	
duplicateCheckEnd:
	li   $v0, 16      	# system call for close file
	syscall            	# close file

	j validWord
invalidWord:
	#will jump back to the correct label in main here
	li $v0, 4				#This will be taken out
	la $a0, invalidWordMessage		#This will be taken out
	syscall					#This will be taken out
	j done					#This will be taken out
validWord:
	#will jump back to the correct label in main here
	li $v0, 4				#This will be taken out
	la $a0, validWordMessage		#This will be taken out
	syscall					#This will be taken out
done:						#This will be taken out