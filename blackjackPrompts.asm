# CS 2640 
# Name: Logan Quon, Brandon Yoon, Adrian Tapia Ceballos, Zakaria El-Assaad
# November 15, 2026
# This is where most of the prompts for the game are stored
# to let the user understand the rules of the game and where in the game he/she is at the moment
.data
	welcomeMessage: .asciiz "Hello and welcome to BLACKJACK! Step right up to take on the dealer and win some awesome prizes"
	rule1Message: .asciiz "\nHOW TO PLAY\n1. The objective of the game is to get a higher valued hand than the dealer BUT is less than or equal to 21."
	rule2Message: .asciiz "\n2. You will wager a certain value before the game starts."
	rule3Message: .asciiz "\n3. You will start with 2 cards visible to you. The dealer will have two cards but only one of them is visible to you."
	rule4Message: .asciiz "\n4. You will have the option to 'hit' (draw a card) or 'stand' (STOP and end your turn)."
	rule5Message: .asciiz "\n5. Remember, be strategic. If your hand value is over 21, YOU LOSE the game and your wager."
	playMessage: .asciiz "\n\nWanna play some Blackjack 1(Yes) 2(No)? Type 1 for yes or 2 for no. "
	
	balanceMessage: .asciiz "\nBalance: $"
	lowBalanceMessage: .asciiz "\nYou don't have enough money to continue playing. Better luck next time!"
	wagerPrompt: .asciiz "\n\nHow much do you want to wager? NOTE: you must wager at least $5 to PLAY. "
.macro welcome()
	# prints welcomeMessage
	li $v0, 4
	la $a0, welcomeMessage
	syscall
	
	# prints rule1Message
	li $v0, 4
	la $a0, rule1Message
	syscall
	
	# prints rule2Message
	li $v0, 4
	la $a0, rule2Message
	syscall
	
	# prints rule3Message
	li $v0, 4
	la $a0, rule3Message
	syscall
	
	# prints rule4Message
	li $v0, 4
	la $a0, rule4Message
	syscall
	
	# prints rule5Message
	li $v0, 4
	la $a0, rule5Message
	syscall
.end_macro 

.macro play()

	# Prompts user to type in 1 (yes) or no (2)
	# User will still be prompted until they type 1 or 2.
	li $v0, 4
	la $a0, playMessage
	syscall
	
	# the value of 1 or 2 will be stored in $s0
	li $v0, 5
	syscall 
	move $s0, $v0 
.end_macro

.macro printBalance()
	li $v0, 4
	la $a0, balanceMessage
	syscall
	
	# prints user balance stored in $s1
	li $v0, 1
	move $a0, $s1
	syscall
.end_macro 

.macro wagerPrompt()

	# prints user balance
	printBalance()
	
	li $v0, 4
	la $a0, wagerPrompt
	syscall
	
	# wagered value will be stored in $s2
	li $v0, 5
	syscall
	move $s2, $v0
	

.end_macro 

.macro printLowBalance()
	
	# prints user balance
	printBalance()
	
	li $v0, 4
	la $a0, lowBalanceMessage
	syscall

.end_macro


.text

