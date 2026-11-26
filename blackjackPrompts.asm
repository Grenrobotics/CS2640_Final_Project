# CS 2640 
# Name: Logan Quon, Brandon Yoon, Adrian Tapia Ceballos, Zakaria El-Assaad
# November 15, 2026
# This is where most of the prompts for the game are stored
# to let the user understand the rules of the game and where in the game he/she is at the moment

# prints string inputed as a parameter
.macro print(%str)
	.data
	str: .asciiz %str
	.text
	li $v0, 4
	la $a0, str
	syscall
.end_macro

.macro welcome()
	# prints welcomeMessage
	print("Hello and welcome to BLACKJACK! Step right up to take on the dealer and win some awesome prizes")
	
	# prints rules on how to play
	print("\n\nHOW TO PLAY")
	print("\n1. The objective of the game is to get a higher valued hand than the dealer BUT is less than or equal to 21.")
	print("\n2. You will wager a certain value before the game starts.")
	print("\n3. You will start with 2 cards visible to you. The dealer will have two cards but only one of them is visible to you.")
	print("\n4. You will have the option to 'hit' (draw a card) or 'stand' (STOP and end your turn).")
	print("\n5. Remember, be strategic. If your hand value is over 21, YOU LOSE the game and your wager.")
.end_macro 

.macro play()

	# Prompts user to type in 1 (yes) or no (2)
	# User will still be prompted until they type 1 or 2.
	print("\n\nWanna play some Blackjack 1(Yes) 2(No)? Type 1 for yes or 2 for no."
	
	# the value of 1 or 2 will be stored in $s0
	li $v0, 5
	syscall 
	move $s0, $v0 
.end_macro

.macro printBalance()
	print("\nBalance: $"
	
	# prints user balance stored in $s1
	li $v0, 1
	move $a0, $s1
	syscall
.end_macro 

.macro wagerPrompt()

	# prints user balance
	printBalance()
	
	print("\n\nHow much do you want to wager? NOTE: you must wager at least $5 to PLAY. ")
	
	# wagered value will be stored in $s2
	li $v0, 5
	syscall
	move $s2, $v0
	

.end_macro 

.macro printLowBalance()
	
	# prints user balance
	printBalance()
	
	print("\nYou don't have enough money to continue playing. Better luck next time!")

.end_macro

.macro hitOrStandPrompt()

	# prints prompt to either hit or stand
	print("Do you want to hit (draw another card) or do you want to stand (stop drawing cards)?\nPlease type 1 for hit or 2 for stand.")
	
	# store value into $s5
	li $v0, 5
	syscall
	move $s5, $v0
.end_macro

.text

