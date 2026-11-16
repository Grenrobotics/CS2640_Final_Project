# CS 2640 
# Name: Logan Quon, Brandon Yoon, Adrian Tapia Ceballos, Zakaria El-Assaad
# November 15, 2026
# Unused file for now. 

.data

.text

# If either computer or player wants to hit
.macro dealCard(%playerNum, %cardValue)
	beq %playerNum, 1, playerTurn
	beq %playerNum, 2, dealerTurn


playerTurn:

dealerTurn:
.end_macro 
