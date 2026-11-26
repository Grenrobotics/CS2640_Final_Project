# CS 2640 
# Name: Logan Quon, Brandon Yoon, Adrian Tapia Ceballos, Zakaria El-Assaad
# November 15, 2026
# This is where the MAIN game loop occurs
# Follows standard blackjack rules

.include "blackjackPrompts.asm"
.include "macros.asm"

.data
Hearts: .asciiz "Hearts"
Diamonds: .asciiz "Diamonds"
Clubs: .asciiz "Clubs"
Spades: .asciiz "Spades"

# storing in array of pointers because I couldn't figure out how to make an array of strings
suits: .word Hearts, Diamonds, Clubs, Spades

Ace: .asciiz "Ace"
Two: .asciiz "2"
Three: .asciiz "3"
Four: .asciiz "4"
Five: .asciiz "5"
Six: .asciiz "6"
Seven: .asciiz "7"
Eight: .asciiz "8"
Nine: .asciiz "9"
Ten: .asciiz "10"
Jack: .asciiz "Jack"
Queen: .asciiz "Queen"
King: .asciiz "King"

ranks: .word Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King

.text

main:
        # Initialize hand totals
        li $s3, 0
        li $s4, 0

        # Starting balance
        li $s1, 100

        welcome()
        play()

        # after player inputs value via play() method,
        # code will jump to either roundLoop, invalid, or exit.
        beq $s0, 1, roundLoop
        beq $s0, 2, exit
        jal invalidPlayInput

	# Check if user is too broke to play
	blt $s1, 5, lowBalance

	# Prompt user for wager
        wagerPrompt()

        # If a user types an invalid integer (wagers less than $5)
        # stores the constant 5 to be compared with in slt.
        li $s5, 5
        sgt $t4, $s2, $s5
        bgt $t4, 0, invalidWager
roundLoop:
        
        # Deduct wagered amount from user's balance
        sub $s1, $s1, $s2

        # Reset hand totals at start of round
        li $s3, 0
        li $s4, 0

        # Sets the current turn to player. (represented by integer 1)
        # the dealer's turn (computers) WILL be represented by integer 2.
        li $t2, 1
        
        #Deal 2 cards to player hand
        jal drawCard
        jal drawCard

     
        #Change turn to dealer ONCE player wants to STOP drawing cards
        li $t2, 2
        
        #Give 2 cards to dealer
        jal drawCard
        jal drawCard

        # Print dealer total ONCE player wants to STOP drawing cards 
		print("\nDealer total: ")

	# Prints out the dealer's cards
        # li $v0, 1
        # move $a0, $s4
        # syscall
        
	# prints newLine
		print("\n")

playerTurn:
	# Print player total
		print("\nPlayer total: ")

        li $v0, 1
        move $a0, $s3
        syscall

		print("\n")
        
	# checks if the PLAYER has busted yet (gets hand value over 21).
	bgt $s3, 21, gameOver
	
	# checks if player achieved 21 or blackjack (face card + ace)
	beq $s3, 21, gameOver
	# checks if the PLAYER 
        hitOrStandPrompt()
        
        # player gets another card if they choose 1.
        # branches to playOn which jumps to drawCard, returning to start of playerTurn
        beq $s5, 1, playOn
        
        
        # will END player's turn if player chooses 2. 
        # decides to stop drawing cards 
        # (stand)
        beq $s5, 2, dealerTurn 

        # jumps back up to continue player's turn.
        j playerTurn
gameOver:

invalidPlayInput:
        play()
        bne $s0, 1, invalidPlayInput
        bne $s0, 2, invalidPlayInput
        jr $ra
# jumps here if player makes invalid wager
invalidWager:
        wagerPrompt()
        blt $s2, 5, invalidWager
        
        #jumps back to middle of roundLoop once player makes valid wager
        jr $ra
# jumps here if the player wants to continue drawing cards.
playOn:
	jal drawCard
	j playerTurn
	
drawCard:
        getCard()
        jr $ra
# if the player does not have enough money to continue playing further.
lowBalance:
	printLowBalance()
	j exit

# TO BE IMPLEMENTED (Can someone do this part? Thanks!)
dealerTurn:

exit:
        li $v0, 10
        syscall
