.data

startingKeyGen: .asciiz "\nStarting keyGen\n"

newLine: .asciiz "\n"
inModValueOne: .asciiz "\nIn Mod Value One"
inModValueTwo: .asciiz "\nIn Mod Value Two"
inModValueThree: .asciiz "\nIn Mod Value Three"
inModValueFour: .asciiz "\nIn Mod Value Four"
inModValueFive: .asciiz "\nIn Mod Value Five"
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

.text

main:
	li $v0, 4
	la $a0, startingKeyGen #Prints "Starting keyGen"
	syscall
	
	li   $v0, 41       	# get a random int
	syscall
	
	divu $t0, $a0, 5   	# mod it by 5 so we can generate a vowel with that vowel
	mfhi $v0
	
	#move $t1, $v0
	#beq $t1, $zero, fixRemainder
	
	addi $v0, $v0, 1	# add 1 to modValue to handle case where the div operation results in 0
	move $s0, $v0 		# move the mod value to $s0
	
	li $v0, 4
	la $a0, modValueIs 	# Prints statement "The mod value is "
	syscall
	
	move $a0, $s0 		# move the modValue to $a0
	li $v0, 1 		# print the mod value, this should be 0, 1, 2, 3 or 4
	syscall
	
	jal getVowel 		# Call the function to return 1 vowel
	
	li $v0, 4
	la $a0, resultsFromGetVowel # Prints "The results from getVowel are : "
	syscall
	
	li $v0, 11
	la $a0, ($v1) # Actually prints the result from getVowel, which should be a character
	syscall
	
	li $v0, 4
	la $a0, goodbye # Terminate the program
	syscall
	
	li $v0, 10
	syscall
	
modValueOne:
	li $v0, 4
	la $a0, inModValueOne
	syscall
	
	la $a0, vowelA  # Get the address
	sb $v1, ($a0)  # Get the value at that address
	
	jr $ra
	
modValueTwo:
	li $v0, 4
	la $a0, inModValueTwo
	syscall
	
	la $a0, vowelE  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	
	jr $ra
	
modValueThree:
	li $v0, 4
	la $a0, inModValueThree
	syscall
	
	la $a0, vowelI  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	
	jr $ra
	
modValueFour:
	li $v0, 4
	la $a0, inModValueFour
	syscall
	
	la $a0, vowelO  # Get the address
	lb $v1, 0($a0)  # Get the value at that address
	
	jr $ra
	
modValueFive:
	li $v0, 4
	la $a0, inModValueFive
	syscall
	
	la $a0, vowelU  # Get the address
	lb $v1, ($a0)  # Get the value at that address
	
	jr $ra

getVowel:
	#a0 holds the mod value, which is 1, 2, 3, 4 or 5 to be mapped to a variable
	move $a1, $a0 #Copy value of $a0 into $a1

	beq $a1, 1 modValueOne #branch if $s0 == 1
	beq $a1, 2 modValueTwo #branch if $s0 == 2
	beq $a1, 3 modValueThree #branch if $s0 == 3
	beq $a1, 4 modValueFour #branch if $s0 == 4
	beq $a1, 5 modValueFive #branch if $s0 == 5
	
	#The following is a hard coded solution to always return vowelA
	#la $a0, vowelA  # Get the address of the vowel
	#lb $v1, 0($a0)  # Store the contents of the vowelAddress into $v1 to return
	
	jr $ra
	
fixRemainder:
	move $v0, $zero
	jr $ra