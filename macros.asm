# CS 2640 
# Name: Logan Quon, Brandon Yoon, Adrian Tapia Ceballos, Zakaria El-Assaad
# November 15, 2026
# here are the macros we are using

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
