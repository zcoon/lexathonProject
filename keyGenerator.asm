.data

startingKeyGen: .asciiz "Starting keyGen" #max length of string input 9 bytes with newline
str_exit: .asciiz "test.txt"
str_data: .asciiz "This is a test!"
fileName: .asciiz "keyword.txt"
newLine: .asciiz "\n"
inModValueZero: .asciiz "\nIn Mod Value Zero"
inModValueOne: .asciiz "\nIn Mod Value One"
inModValueTwo: .asciiz "\nIn Mod Value Two"
inModValueThree: .asciiz "\nIn Mod Value Three"
inModValueFour: .asciiz "\nIn Mod Value Four"
goodbye: .asciiz "Terminating"
modValueIs: .asciiz "Mod value is "

# syscall code 11 is for print character

.text

main:
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
	move $s0, $v0 #move the mod value to $a0
	
	li $v0, 4
	la $a0, modValueIs
	syscall
	
	move $a0, $s0 	#move the modValue to $a0
	li $v0, 1 	#print the mod value, this should be 0, 1, 2, 3 or 4
	syscall
	
	
	
	beq $s0, 0 modValueZero# branch if $s0 == 0
	beq $s0, 1 modValueOne# branch if $s0 == 1
	beq $s0, 2 modValueTwo# branch if $s0 == 2
	beq $s0, 3 modValueThree# branch if $s0 == 3
	beq $s0, 4 modValueFour# branch if $s0 == 4
	
	li $v0, 4
	la $a0, goodbye
	syscall
	
	li $v0, 10
	syscall
	
modValueZero:
	li $v0, 4
	la $a0, inModValueZero
	syscall
	
modValueOne:
	li $v0, 4
	la $a0, inModValueOne
	syscall
	
modValueTwo:
	li $v0, 4
	la $a0, inModValueTwo
	syscall

	
modValueThree:
	li $v0, 4
	la $a0, inModValueThree
	syscall

	
modValueFour:
	li $v0, 4
	la $a0, inModValueFour
	syscall
