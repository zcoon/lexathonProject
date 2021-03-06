.data
	myword: .asciiz "imitation"
	myfile: .asciiz "/Users/juangarcia/duplicateFile.txt"      # filename for input
	newline: .asciiz "\n"
	nullTerminator: .asciiz " "
	buffer: .space 50000	
.text
duplicateCheck:
	# Doesnt need any arguments, just the user's word in some form (a variable 
	# like myword that i used, or in an$a register)
	lb $t1, nullTerminator
	lb $t2, newline
	
	li   $v0, 13       # system call for open file
	la   $a0, myfile   # board file name
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
	lb $s2, myword($t8)	#letter in user's word
	bne $s1, $t2, noNTChange	
	move $s1, $t1		#sets file word letter to null terminator incase its newline
noNTChange:
	bne $s1, $s2, duplicateNotWord
	beq $s1, $t1, match	
	addi $t7, $t7, 1
	addi $t8, $t8, 1
	j duplicateDo
	
match:	addi $v1, $zero, 1
	
	j duplicateCheckEnd
duplicateNotWord:
	subi $t6, $t6, 1

	bne $t5, $zero, duplicateCheckLoop
	addi $t5, $t6, 2
	j duplicateCheckLoop	
duplicateCheckEnd:
	li   $v0, 16      	# system call for close file
	syscall            	# close file
	
	#returns 1 if word is a duplicate, or 0 if it isn't, in $v1
endDuplicateCheck: