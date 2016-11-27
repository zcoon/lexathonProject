.data
	clear:
	duplicateFile: .asciiz "/Users/juangarcia/duplicateFile.txt"	#change to match file path name
.text

cleanDuplicateFile:
	li $v0, 13
    	la $a0, duplicateFile
   	li $a1, 1
   	li $a2, 0
   	syscall  # File descriptor gets returned in $v0

    	move $a0, $v0  # Syscall 15 requieres file descriptor in $a0
    	li $v0, 15
    	la $a1, clear
    	li $a2, 0  # computes the length of the string, this is really a constant
    	syscall

    	li $v0, 16  # $a0 already has the file descriptor
    	syscall
endClean:
