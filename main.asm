# CS 2640 
# Name: Logan Quon, Brandon Yoon, Adrian Tapia Ceballos, Zakaria El-Assaad
# November 15, 2026
# This is where the MAIN game loop occurs
# Follows standard blackjack rules

.include "blackjackPrompts.asm"

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

# ADDED: Display messages
playerTotalText: .asciiz "\nPlayer total: "
dealerTotalText: .asciiz "\nDealer total: "
newLine: .asciiz "\n"
ofText: .asciiz " of "

# lo bound doesn't actually work yet
.macro getRandomInt(%lowerBound, %upperBound)
        li $v0, 42 # 42 calls for a random integer
        li $a0, 0
        li $a1, %upperBound
        syscall # result is stored in $a0
.end_macro

.macro getCard()
        getRandomInt(0,52)

        # quotient is suit(0=H,1=D,2=C,3=S). Register LO
        # remainder is rank(0=Ace,1-9=2-10,10=J,11=Q,12=K). Register HI
        li $t0, 13

        # $a0 HOLDS the value of getRandomInt(0,52)
        div $a0, $t0
        mflo $t0
        mfhi $t1

        

        # $t1 = rank index (0-12)
        # $t3 = blackjack value
        #Checks for special cases such as
        #Face cards and aces
        beq $t1, 0, isAce
        bge $t1, 10, isFaceCard

        # Number cards (2-10)
        #adds 
        addi $t3, $t1, 1
        j cardValueDone

isAce:
	#ACES ARE SEEN AS 1 OR 11
	#THIS CODE SEES IT AS 11 NO MATTER WHAT!!
	#Adds 11 to $t3
        li $t3, 11
        j cardValueDone

isFaceCard:
        li $t3, 10

cardValueDone:
        # $t2 determines whose turn it is
        beq $t2, 1, addPlayer
        beq $t2, 2, addDealer
        j handValueDone

addPlayer:
        add $s3, $s3, $t3
        j handValueDone

addDealer:
        add $s4, $s4, $t3

handValueDone:
        # find address of suit string in array
        mul $t0, $t0, 4
        la $a0, suits
        add $t0, $a0, $t0
        lw $t0, 0($t0)

        # find address of rank string in array
        mul $t1, $t1, 4
        la $a0, ranks
        add $t1, $a0, $t1
        lw $t1, 0($t1)

        # print rank
        li $v0, 4
        move $a0, $t1
        syscall

        # Print " of "
        li $v0, 4
        la $a0, ofText
        syscall

        # print suit
        li $v0, 4
        move $a0, $t0
        syscall

        # Print newline
        li $v0, 4
        la $a0, newLine
        syscall

.end_macro

.text

main:
        # Initialize hand totals
        li $s3, 0
        li $s4, 0

        # Starting money
        li $s1, 100

        welcome()
        play()

        # after player inputs value via play() method,
        # code will jump to either roundLoop, invalid, or exit.
        beq $s0, 1, roundLoop
        beq $s0, 2, exit
        j invalidPlayInput

roundLoop:
        # Starting money for player WILL ALWAYS BE $100 (can be changed)
        li $s1, 100
        wagerPrompt()

        # If a user types an integer
        blt $s2, 5, invalidWager

        # Reset hand totals at start of round
        li $s3, 0
        li $s4, 0

        # Sets the current turn to player. (represented by integer 1)
        # the dealer's turn (computers) WILL be represented by integer 2.
        li $t2, 1
        #Deal 2 cards to player hand
        jal drawCard
        jal drawCard

        # Print player total
        li $v0, 4
        la $a0, playerTotalText
        syscall

        li $v0, 1
        move $a0, $s3
        syscall

        li $v0, 4
        la $a0, newLine
        syscall

        
        #Change turn to dealer
        li $t2, 2
        #Give 2 cards to dealer
        jal drawCard
        jal drawCard

        # Print dealer total
        li $v0, 4
        la $a0, dealerTotalText
        syscall

        li $v0, 1
        move $a0, $s4
        syscall

        li $v0, 4
        la $a0, newLine
        syscall

        # Return to play menu
        j invalidPlayInput

invalidPlayInput:
        #play()
        beq $s0, 1, roundLoop
        beq $s0, 2, exit
        j invalidPlayInput

invalidWager:
        wagerPrompt()
        bge $s2, 5, roundLoop
        j invalidWager
drawCard:
        getCard()
        jr $ra

exit:
        li $v0, 10
        syscall
