.data
	wordLength:		.word 0
	validWordMessage: 	.asciiz "Valid word"		#This will be taken out
	invalidWordMessage:	.asciiz "Invalid word"		#This will be taken out
	
	userWord: 		.asciiz "thxerx"		#will be passed in from main
	keyLetter:		.asciiz "a"			#...
	gridArray: 		.asciiz "hpry"			#...
	
	nullterminator:		.asciiz ""
	duplicateFile: 		.asciiz "/duplicateFile.txt"      # filename for input
	newline: 		.asciiz "\n"
	buffer: 		.space 2000000	
	fileword: .space 30
	alphabet: .asciiz "abcdefghijklmnopqrstuvwxyz"
	Afile: .asciiz "/awords.txt"      # filename for input
	Bfile: .asciiz "/bwords.txt"      # filename for input
	Cfile: .asciiz "/cwords.txt"      # filename for input
	Dfile: .asciiz "/dwords.txt"      # filename for input
	Efile: .asciiz "/ewords.txt"      # filename for input
	Ffile: .asciiz "/fwords.txt"      # filename for input
	Gfile: .asciiz "/gwords.txt"      # filename for input
	Hfile: .asciiz "/hwords.txt"      # filename for input
	Ifile: .asciiz "/iwords.txt"      # filename for input
	Jfile: .asciiz "/jwords.txt"      # filename for input
	Kfile: .asciiz "/kwords.txt"      # filename for input
	Lfile: .asciiz "/lwords.txt"      # filename for input
	Mfile: .asciiz "/mwords.txt"      # filename for input
	Nfile: .asciiz "/nwords.txt"      # filename for input
	Ofile: .asciiz "/owords.txt"      # filename for input
	Pfile: .asciiz "/pwords.txt"      # filename for input
	Qfile: .asciiz "/qwords.txt"      # filename for input
	Rfile: .asciiz "/rwords.txt"      # filename for input
	Sfile: .asciiz "/swords.txt"      # filename for input
	Tfile: .asciiz "/twords.txt"      # filename for input
	Ufile: .asciiz "/uwords.txt"      # filename for input
	Vfile: .asciiz "/vwords.txt"      # filename for input
	Wfile: .asciiz "/wwords.txt"      # filename for input
	Xfile: .asciiz "/xwords.txt"      # filename for input
	Yfile: .asciiz "/ywords.txt"      # filename for input
	Zfile: .asciiz "/zwords.txt"      # filename for input
.text
checkKey:
	lb $t0, keyLetter 	
keyLoop:
        lb $t1, userWord($t2)
        addi $t2, $t2, 1
        beq $t1, $t3, invalidWord	#null check
        beq $t1, $t0, keyDone		#key check
        j keyLoop
keyDone:
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	
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
	bgt $t0, 90, invalidWord
	blt $t0, 33, invalidWord
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

	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	add $t7, $zero, $zero
	add $t8, $zero, $zero
	add $s1, $zero, $zero
	add $s2, $zero, $zero
							
checkWordDictionary:
	la $a0, userWord		#word
	la $a1, alphabet
	lw $a3, wordLength($0)

	lb $t0, 0($a0)		
	
	lb $t1, 0($a1)		
	bne $t0, $t1, bWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Afile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Aloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Aend	#branch if it's the end of the file	
	bne $t0, $t3, Aloop	#branch if it's not a newline
	beq $t5, $zero, AfirstStart
	addi $t5, $t6, 2
AfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, AnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Ado:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Anotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Ado	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Aend
Anotword:
	subi $t6, $t6, 1			
AnotLength:
	bne $t5, $zero, Aloop		
	addi $t5, $t6, 2
	j Aloop
Aend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end
	
	j goBack  
bWords:
	lb $t1, 1($a1)		
	bne $t0, $t1, cWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Bfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Bloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Bend	#branch if it's the end of the file	
	bne $t0, $t3, Bloop	#branch if it's not a newline
	beq $t5, $zero, BfirstStart
	addi $t5, $t6, 2
BfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, BnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Bdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Bnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Bdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Bend
Bnotword:
	subi $t6, $t6, 1			
BnotLength:
	bne $t5, $zero, Bloop		
	addi $t5, $t6, 2
	j Bloop
Bend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end
	j goBack 
cWords:
	lb $t1, 2($a1)		
	bne $t0, $t1, dWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Cfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Cloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Cend	#branch if it's the end of the file	
	bne $t0, $t3, Cloop	#branch if it's not a newline
	beq $t5, $zero, CfirstStart
	addi $t5, $t6, 2
CfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, CnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Cdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Cnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Cdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Cend
Cnotword:
	subi $t6, $t6, 1			
CnotLength:
	bne $t5, $zero, Cloop		
	addi $t5, $t6, 2
	j Cloop
Cend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end
	j goBack 
dWords:
	lb $t1, 3($a1)		
	bne $t0, $t1, eWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Dfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Dloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Dend	#branch if it's the end of the file	
	bne $t0, $t3, Dloop	#branch if it's not a newline
	beq $t5, $zero, DfirstStart
	addi $t5, $t6, 2
DfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, DnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Ddo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Dnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Ddo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Dend
Dnotword:
	subi $t6, $t6, 1			
DnotLength:
	bne $t5, $zero, Dloop		
	addi $t5, $t6, 2
	j Dloop
Dend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end	
	j goBack 
eWords:
	lb $t1, 4($a1)		
	bne $t0, $t1, fWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Efile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Eloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Eend	#branch if it's the end of the file	
	bne $t0, $t3, Eloop	#branch if it's not a newline
	beq $t5, $zero, EfirstStart
	addi $t5, $t6, 2
EfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, EnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Edo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Enotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Edo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Eend
Enotword:
	subi $t6, $t6, 1			
EnotLength:
	bne $t5, $zero, Eloop		
	addi $t5, $t6, 2
	j Eloop
Eend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end		
	j goBack 
fWords:
	lb $t1, 5($a1)		
	bne $t0, $t1, gWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Ffile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Floop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Fend	#branch if it's the end of the file	
	bne $t0, $t3, Floop	#branch if it's not a newline
	beq $t5, $zero, FfirstStart
	addi $t5, $t6, 2
FfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, FnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Fdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Fnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Fdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Fend
Fnotword:
	subi $t6, $t6, 1			
FnotLength:
	bne $t5, $zero, Floop		
	addi $t5, $t6, 2
	j Floop
Fend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end		
	j goBack 
gWords:
	lb $t1, 6($a1)		
	bne $t0, $t1, hWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Gfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Gloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Gend	#branch if it's the end of the file	
	bne $t0, $t3, Gloop	#branch if it's not a newline
	beq $t5, $zero, GfirstStart
	addi $t5, $t6, 2
GfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, GnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Gdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Gnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Gdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Gend
Gnotword:
	subi $t6, $t6, 1			
GnotLength:
	bne $t5, $zero, Gloop		
	addi $t5, $t6, 2
	j Gloop
Gend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end		
	j goBack 
hWords:
	lb $t1, 7($a1)		
	bne $t0, $t1, iWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Hfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Hloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Hend	#branch if it's the end of the file	
	bne $t0, $t3, Hloop	#branch if it's not a newline
	beq $t5, $zero, HfirstStart
	addi $t5, $t6, 2
HfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, HnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Hdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Hnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Hdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Hend
Hnotword:
	subi $t6, $t6, 1			
HnotLength:
	bne $t5, $zero, Hloop		
	addi $t5, $t6, 2
	j Hloop
Hend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end				
	j goBack 
iWords:
	lb $t1, 8($a1)		
	bne $t0, $t1, jWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Ifile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Iloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Iend	#branch if it's the end of the file	
	bne $t0, $t3, Iloop	#branch if it's not a newline
	beq $t5, $zero, IfirstStart
	addi $t5, $t6, 2
IfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, InotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Ido:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Inotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Ido	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Iend
Inotword:
	subi $t6, $t6, 1			
InotLength:
	bne $t5, $zero, Iloop		
	addi $t5, $t6, 2
	j Iloop
Iend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end				
	j goBack 	
jWords:
	lb $t1, 9($a1)		
	bne $t0, $t1, kWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Jfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Jloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Jend	#branch if it's the end of the file	
	bne $t0, $t3, Jloop	#branch if it's not a newline
	beq $t5, $zero, JfirstStart
	addi $t5, $t6, 2
JfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, JnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Jdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Jnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Jdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Jend
Jnotword:
	subi $t6, $t6, 1			
JnotLength:
	bne $t5, $zero, Jloop		
	addi $t5, $t6, 2
	j Jloop
Jend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end				
	j goBack 
kWords:
	lb $t1, 10($a1)		
	bne $t0, $t1, lWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Kfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Kloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Kend	#branch if it's the end of the file	
	bne $t0, $t3, Kloop	#branch if it's not a newline
	beq $t5, $zero, KfirstStart
	addi $t5, $t6, 2
KfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, KnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Kdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Knotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Kdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Kend
Knotword:
	subi $t6, $t6, 1			
KnotLength:
	bne $t5, $zero, Kloop		
	addi $t5, $t6, 2
	j Kloop
Kend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end				
	j goBack 
lWords:
	lb $t1, 11($a1)		
	bne $t0, $t1, mWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Lfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Lloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Lend	#branch if it's the end of the file	
	bne $t0, $t3, Lloop	#branch if it's not a newline
	beq $t5, $zero, LfirstStart
	addi $t5, $t6, 2
LfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, LnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Ldo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Lnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Ldo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Lend
Lnotword:
	subi $t6, $t6, 1			
LnotLength:
	bne $t5, $zero, Lloop		
	addi $t5, $t6, 2
	j Lloop
Lend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end				
	j goBack 
mWords:
	lb $t1, 12($a1)		
	bne $t0, $t1, nWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Mfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Mloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Mend	#branch if it's the end of the file	
	bne $t0, $t3, Mloop	#branch if it's not a newline
	beq $t5, $zero, MfirstStart
	addi $t5, $t6, 2
MfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, MnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Mdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Mnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Mdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Mend
Mnotword:
	subi $t6, $t6, 1			
MnotLength:
	bne $t5, $zero, Mloop		
	addi $t5, $t6, 2
	j Mloop
Mend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end				
	j goBack 
nWords:
	lb $t1, 13($a1)		
	bne $t0, $t1, oWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Nfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Nloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Nend	#branch if it's the end of the file	
	bne $t0, $t3, Nloop	#branch if it's not a newline
	beq $t5, $zero, NfirstStart
	addi $t5, $t6, 2
NfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, NnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Ndo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Nnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Ndo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Nend
Nnotword:
	subi $t6, $t6, 1			
NnotLength:
	bne $t5, $zero, Nloop		
	addi $t5, $t6, 2
	j Nloop
Nend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end				
	j goBack 
oWords:
	lb $t1, 14($a1)		
	bne $t0, $t1, pWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Ofile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Oloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Oend	#branch if it's the end of the file	
	bne $t0, $t3, Oloop	#branch if it's not a newline
	beq $t5, $zero, OfirstStart
	addi $t5, $t6, 2
OfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, OnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Odo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Onotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Odo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Oend
Onotword:
	subi $t6, $t6, 1			
OnotLength:
	bne $t5, $zero, Oloop		
	addi $t5, $t6, 2
	j Oloop
Oend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end				
	j goBack 
pWords:
	lb $t1, 15($a1)		
	bne $t0, $t1, qWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Pfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Ploop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Pend	#branch if it's the end of the file	
	bne $t0, $t3, Ploop	#branch if it's not a newline
	beq $t5, $zero, PfirstStart
	addi $t5, $t6, 2
PfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, PnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Pdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Pnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Pdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Pend
Pnotword:
	subi $t6, $t6, 1			
PnotLength:
	bne $t5, $zero, Ploop		
	addi $t5, $t6, 2
	j Ploop
Pend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end				
	j goBack 
qWords:
	lb $t1, 16($a1)		
	bne $t0, $t1, rWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Qfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Qloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Qend	#branch if it's the end of the file	
	bne $t0, $t3, Qloop	#branch if it's not a newline
	beq $t5, $zero, QfirstStart
	addi $t5, $t6, 2
QfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, QnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Qdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Qnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Qdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Qend
Qnotword:
	subi $t6, $t6, 1			
QnotLength:
	bne $t5, $zero, Qloop		
	addi $t5, $t6, 2
	j Qloop
Qend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end				
	j goBack 
rWords:
	lb $t1, 17($a1)		
	bne $t0, $t1, sWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Rfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Rloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Rend	#branch if it's the end of the file	
	bne $t0, $t3, Rloop	#branch if it's not a newline
	beq $t5, $zero, RfirstStart
	addi $t5, $t6, 2
RfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, RnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Rdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Rnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Rdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Rend
Rnotword:
	subi $t6, $t6, 1			
RnotLength:
	bne $t5, $zero, Rloop		
	addi $t5, $t6, 2
	j Rloop
Rend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end				
	j goBack 
sWords:
	lb $t1, 18($a1)		
	bne $t0, $t1, tWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Sfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Sloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Send	#branch if it's the end of the file	
	bne $t0, $t3, Sloop	#branch if it's not a newline
	beq $t5, $zero, SfirstStart
	addi $t5, $t6, 2
SfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, SnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Sdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Snotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Sdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Send
Snotword:
	subi $t6, $t6, 1			
SnotLength:
	bne $t5, $zero, Sloop		
	addi $t5, $t6, 2
	j Sloop
Send:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end		
	j goBack 
tWords:
	lb $t1, 19($a1)		
	bne $t0, $t1, uWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Tfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Tloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Tend	#branch if it's the end of the file	
	bne $t0, $t3, Tloop	#branch if it's not a newline
	beq $t5, $zero, TfirstStart
	addi $t5, $t6, 2
TfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, TnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Tdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Tnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Tdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Tend
Tnotword:
	subi $t6, $t6, 1			
TnotLength:
	bne $t5, $zero, Tloop		
	addi $t5, $t6, 2
	j Tloop
Tend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end		
	j goBack 
uWords:
	lb $t1, 20($a1)		
	bne $t0, $t1, vWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Ufile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Uloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Uend	#branch if it's the end of the file	
	bne $t0, $t3, Uloop	#branch if it's not a newline
	beq $t5, $zero, UfirstStart
	addi $t5, $t6, 2
UfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, UnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Udo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Unotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Udo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Uend
Unotword:
	subi $t6, $t6, 1			
UnotLength:
	bne $t5, $zero, Uloop		
	addi $t5, $t6, 2
	j Uloop
Uend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end		
	j goBack 
vWords:
	lb $t1, 21($a1)		
	bne $t0, $t1, wWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Vfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Vloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Vend	#branch if it's the end of the file	
	bne $t0, $t3, Vloop	#branch if it's not a newline
	beq $t5, $zero, VfirstStart
	addi $t5, $t6, 2
VfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, VnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Vdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Vnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Vdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Vend
Vnotword:
	subi $t6, $t6, 1			
VnotLength:
	bne $t5, $zero, Vloop		
	addi $t5, $t6, 2
	j Vloop
Vend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end		
	j goBack 
wWords:
	lb $t1, 22($a1)		
	bne $t0, $t1, xWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Wfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Wloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Wend	#branch if it's the end of the file	
	bne $t0, $t3, Wloop	#branch if it's not a newline
	beq $t5, $zero, WfirstStart
	addi $t5, $t6, 2
WfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, WnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Wdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Wnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Wdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Wend
Wnotword:
	subi $t6, $t6, 1			
WnotLength:
	bne $t5, $zero, Wloop		
	addi $t5, $t6, 2
	j Wloop
Wend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end		
	j goBack 
xWords:
	lb $t1, 23($a1)		
	bne $t0, $t1, yWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Xfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Xloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Xend	#branch if it's the end of the file	
	bne $t0, $t3, Xloop	#branch if it's not a newline
	beq $t5, $zero, XfirstStart
	addi $t5, $t6, 2
XfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, XnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Xdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Xnotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Xdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Xend
Xnotword:
	subi $t6, $t6, 1			
XnotLength:
	bne $t5, $zero, Xloop		
	addi $t5, $t6, 2
	j Xloop
Xend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end		
	j goBack 
yWords:
	lb $t1, 24($a1)		
	bne $t0, $t1, zWords
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Yfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Yloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Yend	#branch if it's the end of the file	
	bne $t0, $t3, Yloop	#branch if it's not a newline
	beq $t5, $zero, YfirstStart
	addi $t5, $t6, 2
YfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, YnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Ydo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Ynotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Ydo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Yend
Ynotword:
	subi $t6, $t6, 1			
YnotLength:
	bne $t5, $zero, Yloop		
	addi $t5, $t6, 2
	j Yloop
Yend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end		
	j goBack 
zWords:
##########################################################		file	begin	
	#open a file for writing
	li   $v0, 13       # system call for open file
	la   $a0, Zfile    # board file name
	li   $a1, 0        # Open for reading
	li   $a2, 0
	syscall            # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 

	#read from file
	li   $v0, 14       # system call for read from file
	move $a0, $s6      # file descriptor 
	la   $a1, buffer   # address of buffer to which to read
	li   $a2, 2000000       # hardcoded buffer length
	syscall            # read from file
	
	lb $t1, nullterminator
	lb $t3, newline
Zloop:	
	lb $t0, buffer($t2)
	addi $t2, $t2, 1
	beq $t0, $t1, Zend	#branch if it's the end of the file	
	bne $t0, $t3, Zloop	#branch if it's not a newline
	beq $t5, $zero, ZfirstStart
	addi $t5, $t6, 2
ZfirstStart:	
	subi $t6, $t2, 2		# $t5 to $t6 holds a word from file	
	
	sub $t8, $t6, $t5
	addi $t8, $t8, 1
	
	bne $t8, $a3, ZnotLength
			#holds word of correct length
	addi $t6, $t6, 1
	add $t9, $t5, $zero
	add $s2, $zero, $zero
Zdo:	lb $s0, buffer($t9)	#compares ith letter of myword to ith letter of word in dictionary
	lb $s1, userWord($s2)
	bne $s0, $s1, Znotword
	
	addi $t9, $t9, 1
	addi $s2, $s2, 1		
	bne $t9, $t6, Zdo	#loop that iterates whole word through $t5
	
	addi $v1, $zero, 1		# return 1 for true, ie word exists
	
	j Zend
Znotword:
	subi $t6, $t6, 1			
ZnotLength:
	bne $t5, $zero, Zloop		
	addi $t5, $t6, 2
	j Zloop
Zend:			# Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall            # close file
##########################################################		file	end		
	 
goBack:
	jr $ra
endCheckWordDictionary:		
	add $t0, $zero, $zero
	beq $v1, $t0, invalidWord 
	
	j validWord
invalidWord:
	#will jump back to the correct label in main here
	li $v0, 4				
	la $a0, invalidWordMessage		
	syscall					
	j userInputFunction			
validWord:
	#will jump back to the correct label in main here
	li $v0, 4				
	la $a0, validWordMessage		
	syscall	
	
	j validUserInput			

