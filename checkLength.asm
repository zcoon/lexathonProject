

 .data
 userInput: .space 9	
 str1:  .asciiz "Enter a word (4-9 letters): "
string: .asciiz "test string"
printLength: .asciiz "The length of the string: "
 .text
 
 
main:
	la $a0,str1 #Prompting the user for input
         li $v0,4
         syscall
         
          li $v0,8 #take in input
         la $a0, userInput #load byte space into address
         li $a1, 9 # allot the byte space for string
         move $t0,$a0 #save string to t0
         syscall
         
         la $a0, userInput #reload byte space to primary address
         move $a0,$t0 # primary address = t0 address (load pointer)
         syscall
         
         



 	la $a0, ($t0)           # Load address of string.
         jal checkLength              # Call checkLength procedure.
        jal print
     	addi $a1, $a0, 0        # Move address of string to $a1
        addi $v1, $v0, 0        # Move length of string to $v1
        addi $v0, $0, 11        # System call code for message.
        la $a0, printLength           # Address of message.
        syscall
        
        
        addi $v0, $0, 10        # System call code for exit.
        syscall
        
 #***********************CHECK LENGTH**********************************************      
	checkLength:
		li $t0, 0 # initialize the count to zero
		loop:
		lb $t1, 0($a0) # load the next character into t1
		beqz $t1, exit # check for the null character
		addi $a0, $a0, 1 # increment the string pointer
		addi $t0, $t0, 1 # increment the count
		j loop # return to the top of the loop
		exit:
		jr $ra
 #************************************************************************************       

	print:
	  li $v0, 4
	  la $a0, printLength
	  syscall

	  li $v0, 1
	  move $a0, $t0
  	  syscall

	   jr $ra
#************************Printing the length of the string*************************************
#NOTE: This function is only for testing. 
#Need to return boolean 0 for invalid input
#Need to return 1 for valid input (4-9) characters.






