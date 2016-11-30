#Lexathon Timer
#Zac Cooner
#zmc130030
#11/22/16

.data
displayTime: .asciiz "Time remaining: "
timeRemaining:.word 60 #reset each game!!!
currentTime: .word 0
gameTime: .word 0
remainingTime: .word 0
youHaveTimeLeft: .asciiz "You have time left!"
timeHasRunOutMessage: .asciiz "You don't have time left!"
newLine: .asciiz "\n"

#################
# The way the Timer function is supposed to work, we need to call getTimeCurrent
# when the game begins, and store that value in a .word which we can call beginningTime.
# We should also have a variable called timeRemaining which we initialize to 60 if the user initially has 60 seconds.
# Then each time the user moves, we will call the getTimeElapsed function.
# This will give us the value from subtracting the beginningTime from the beginningTime.
# Then we will subtract that value from the timeRemaining with the formula timeRemaining = timeRemaining - (result of getTimeElapsed).
# Then we should use the slt function to say $slt timeValid, timeRemaining, $zero.
# This will set timeValid (a new .word variable) to 1 if timeRemaining is less than 0.
# Then if timeValid = 1, we will terminate the program

	
#Adds 20 seconds to the timer
addTime:
	lw $t1, timeAvailable
	add $t1, $t1, 20
	sw $t1, timeAvailable
	jr $ra
	
#Finds current system time and outputs it (as seconds) on $v0
#Should be called every time a new game is started, so that getTimeElapsed only returns time since the beginning of that game.
getTimeCurrent:
	li $v0, 30				#Syscall 30 to get systime in ms
	syscall					#Now $a0 has lower 32 bits of system time
	
	li $t0, 1000			#This converts system time from milliseconds to seconds
	div $a0, $t0			#Lo will now hold the seconds value
	mflo $v0			#Return the seconds
	jr $ra	
	
#Last call of current time should be saved on $a1 first
#Difference since then put on $v0				
getTimeElapsed:					#parameter is $a1 (start)
	lw $a1, currentTime
	addi $sp, $sp, -8
	sw $ra, ($sp)
	sw $a1, 4($sp)
	jal getTimeCurrent			#find currentTime, and put it on $v0
	lw $t0, 4($sp)				#load startTime onto $t0
	lw $ra, ($sp)
	addi $sp, $sp, 8
	sub $v0, $v0, $t0			#Calculate difference in time and return it on $v0
	jr $ra

	
