#Lexathon Timer
#Zac Cooner
#zmc130030
#11/22/16

.data
displayTime: .asciiz "Time remaining: "
timeAvailable:.word 60 #reset each game!!!
currentTime: .word 0
gameTime: .word 0
remainingTime: .word 0
youHaveTimeLeft: .asciiz "You have time left!"
timeHasRunOutMessage: .asciiz "You don't have time left!"
newLine: .asciiz "\n"

	
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

	
