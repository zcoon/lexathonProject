.data

startingKeyGen: .asciiz "\nStarting keyGen" #max length of string input 9 bytes with newline
str_exit: .asciiz "test.txt"
str_data: .asciiz "This is a test!"
fileName: .asciiz "keyword.txt"
newLine: .asciiz "\n"
inModValueZero: .asciiz "\nIn Mod Value Zero"
inModValueOne: .asciiz "\nIn Mod Value One"
inModValueTwo: .asciiz "\nIn Mod Value Two"
inModValueThree: .asciiz "\nIn Mod Value Three"
inModValueFour: .asciiz "\nIn Mod Value Four"
goodbye: .asciiz "\nTerminating"
modValueIs: .asciiz "Mod value is "
tempValueIs: .asciiz "Temp value is "
resultsFromGetVowel: .asciiz "\nThe result from getVowel is: "

## VOWELS
vowelA: .byte 'a'
vowelE: .byte 'e'
vowelI: .byte 'i'
vowelO: .byte 'o'
vowelU: .byte 'u'
keyVowel: .byte 'a' #Populate this value with one of the vowels above

.text

main:
	li $v0, 11        # syscall code 11 is for print character
	lb $a0, vowelE	  # print E vowel for testing
	syscall

	li $v0, 4
	la $a0, startingKeyGen
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	####
	li   $v0, 41       # get a random int
	syscall
	divu $t0, $a0, 5   #mod it by 5 so we can generate a vowel 
	mfhi $v0
	move $s0, $v0 #move the mod value to $s0
	
	li $v0, 4
	la $a0, modValueIs
	syscall
	
	move $a0, $s0 	#move the modValue to $a0
	li $v0, 1 	#print the mod value, this should be 0, 1, 2, 3 or 4
	syscall
	
	## This is where beq statements were
	
	jal getVowel 	# Call the function to return 1 vowel
	
	li $v0, 4
	la $a0, resultsFromGetVowel
	syscall
	
	li $v0, 11
	la $a0, ($v1)
	syscall
	
	li $v0, 4
	la $a0, goodbye
	syscall
	
	li $v0, 10
	syscall
	
modValueZero:
	li $v0, 4
	la $a0, inModValueZero
	syscall
	
	la $a0, vowelA  # Get the address
	sb $v1, ($a0)  # Get the value at that address
	
modValueOne:
	li $v0, 4
	la $a0, inModValueOne
	syscall
	
	la $a0, vowelE  # Get the address
	sb $v1, ($a0)  # Get the value at that address
	
modValueTwo:
	li $v0, 4
	la $a0, inModValueTwo
	syscall
	
	la $a0, vowelI  # Get the address
	sb $v1, ($a0)  # Get the value at that address
	
modValueThree:
	li $v0, 4
	la $a0, inModValueThree
	syscall
	
	la $a0, vowelO  # Get the address
	sb $v1, 0($a0)  # Get the value at that address
	
modValueFour:
	li $v0, 4
	la $a0, inModValueFour
	syscall
	
	la $a0, vowelU  # Get the address
	sb $v1, ($a0)  # Get the value at that address
	

getVowel:
#a0 holds the mod value
	move $a1, $a0 #Copy value of $a0 into $a1
	beq $a1, 0 modValueZero #branch if $s0 == 0
	beq $a1, 1 modValueOne #branch if $s0 == 1
	beq $a1, 2 modValueTwo #branch if $s0 == 2
	beq $a1, 3 modValueThree #branch if $s0 == 3
	beq $a1, 4 modValueFour #branch if $s0 == 4
	
	la $a0, vowelA  # Get the address
	#sb $v1, ($a0)  # Get the value at that address
	lb $v1, 0($a0)
	
	jr $ra