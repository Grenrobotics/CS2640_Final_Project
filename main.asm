# black jack program
# 

.data

Hearts:   .asciiz "Hearts"
Diamonds: .asciiz "Diamonds"
Clubs:    .asciiz "Clubs"
Spades:   .asciiz "Spades"

# storing in array of pointers because I couldn't figure out how to make an array of strings
suits:    .word Hearts, Diamonds, Clubs, Spades


Ace:      .asciiz "Ace"
Two:      .asciiz "2"
Three:    .asciiz "3"
Four:     .asciiz "4"
Five:     .asciiz "5"
Six:      .asciiz "6"
Seven:    .asciiz "7"
Eight:    .asciiz "8"
Nine:     .asciiz "9"
Ten:      .asciiz "10"
Jack:     .asciiz "Jack"
Queen:    .asciiz "Queen"
King:     .asciiz "King"

ranks:    .word Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King

# Adrian: I made this macro but it could honestly be moved into the getCard() instead.
.macro getRandomInt(%lowerBound, %upperBound)
	li $v0, 42
	li $a0, 0 
	li $t0, %upperBound
	sub $t0, $t0, %lowerBound
	move $a1, $t0
	syscall # result is stored in $a0
	add $a0, $a0, %lowerBound
	
.end_macro

.macro getCard()
# suit and rank address are stored inside of $t0 and $t1 currently. 
# We could store in HI and LO instead maybe.

	getRandomInt(0,51) # range is still 52 distinct numbers
	# quotient is suit(0=H,1=D,2=C,3=S). Register LO
	# remainder is rank(0=Ace,1-9=1-9,10=J,11=Q,12=K). Register HI
	li $t0, 13
	div $a0, $t0
	mflo $t0
	mfhi $t1
	
	# find address of suit string in array
	mul $t0, $t0, 4 # multiply quotient by 4 to find the offset
	la $a0, suits
	add $t0, $a0, $t0
	lw $t0, 0($t0)
	
	# find address of rank string in array 
	mul $t1, $t1, 4 # multiply remainder by 4 to find offset
	la $a0, ranks
	add $t1, $a0, $t1
	lw $t1, 0($t1)
	
	# print suit and rank
	li $v0, 4
	la $a0, 0($t1)
	syscall
	
	li $v0, 4
	la $a0, 0($t0)
	syscall

.end_macro

.text

main:
	getCard()
	
	li $v0, 10
	syscall
