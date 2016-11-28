#Lexathon Timer
#Zac Cooner
#zmc130030
#11/22/16

.data
welcomeTimer: .asciiz "Welcome to the timer!\n" 
timeRemaining: .asciiz "The time remaining is : "
timeUp: .asciiz "The time us up"
timeAvailable: .word 60 # This should be reset each time
currentTime: .word 0
gameTime: .word 0
remainingTime: .word 0

.text

main:

	li $v0,4
	la $a0, welcomeTimer
	syscall
	
	li $v0,4
	la $a0, timeRemaining
	syscall
	
	jal returnGameTime
	
	li $v0, 4
	la $a0, ($v0)
	
	li $v0, 10
	syscall
	
	
#Stores time remaining in output $v0
returnGameTime:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	lw $t4, timeAvailable
	jal getTimeElapsed
	sub $v0, $t4, $v0
	sw $v0, gameTime
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra	
	
#Adds 20 seconds to the timer
addTime:
	lw $t1, timeAvailable
	add $t1, $t1, 20
	sw $t1, timeAvailable
	jr $ra
	
#Finds current system time and outputs it (as seconds) on $v0
#Should be called every time a new board is generated, so that getTimeElapsed only returns time since that board's inception.
getTimeCurrent:
	li $v0, 30				#syscall 30 to get systime in ms
	syscall					#now $a0 has lower 32 bits of system time
	
	li $t0, 1000			#convert system time from milliseconds to seconds
	div $a0, $t0			#lo holds seconds
	mflo $v0				#return seconds
	jr $ra	
	
#Last call of current time should be saved on $a1 first
#Difference since then put on $v0				
getTimeElapsed:					#parameter is $a1 (start)
	lw $a1, currentTime
	addi $sp, $sp, -8
	sw $ra, ($sp)
	sw $a1, 4($sp)
	jal getTimeCurrent			#find currentTime, and get it on $v0
	lw $t0, 4($sp)			#load startTime onto $t0
	lw $ra, ($sp)
	addi $sp, $sp, 8
	sub $v0, $v0, $t0			#get difference in time
	jr $ra

	
