# CS 2640
# Logan Quon
# This file contains the prompts the user will see when the game starts
.data
	welcomeMessage: .asciiz "Hello and welcome to BLACKJACK! Step right up to take on the dealer and win some awesome prizes"
	rule1Message: .asciiz "\nHOW TO PLAY\n1. The objective of the game is to get a higher valued hand than the dealer BUT is less than or equal to 21."
	rule2Message: .asciiz "\n2. You will wager a certain value before the game starts."
	rule3Message: .asciiz "\n3. You will start with 2 cards visible to you. The dealer will have two cards but only one of them is visible to you."
	rule4Message: .asciiz "\n4. You will have the option to 'hit' (draw a card) or 'stand' (STOP and end your turn)."
	rule5Message: .asciiz "\n5. Remember, be strategic. If your hand value is over 21, YOU LOSE the game and your wager."
	playMessage: .asciiz "\n\nWanna play some Blackjack 1(Yes) 2(No)? Type 1 for yes or two for no."
.macro welcome()
	
	li $v0, 4
	la $a0, welcomeMessage
	syscall
	
	li $v0, 4
	la $a0, rule1Message
	syscall
	
	li $v0, 4
	la $a0, rule2Message
	syscall
	
	li $v0, 4
	la $a0, rule3Message
	syscall
	
	li $v0, 4
	la $a0, rule4Message
	syscall
	
	li $v0, 4
	la $a0, rule5Message
	syscall
.end_macro 

.macro play()
	li $v0, 4
	la $a0, playMessage
	syscall
.end_macro


.text
	# TESTING only
	welcome()
	play()
	li $v0, 10
	syscall