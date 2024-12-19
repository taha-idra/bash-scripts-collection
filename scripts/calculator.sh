#!/bin/bash
#
# Script Name: calculator.sh
# Description: A simple calculator script that supports addition, subtraction, multiplication, division, square, square root, and percentage operations.
#
# Usage:
# 1. Make the script executable: chmod +x calculator.sh
# 2. Run the script: ./calculator.sh or bash calculator.sh
#
# Author: Taha Idra
# Version: 0.1.0-alpha
# Date: 2024-12-19

# Variables for storing numbers
NUM1=0
NUM2=0
NUM=0

# Start an infinite loop to show the menu until the user decides to exit
while true; do
	# Display available operations
	echo "1) Addition"
	echo "2) Subtraction"
	echo "3) Multiplication"
	echo "4) Division"
	echo "5) Square"
	echo "6) Square Root"
	echo "7) Percentage"
	echo "8) Exit"

	# Ask the user to select an operation
	echo "Select an operation to perform:"
	read CHOOSE

	# Handle different operations based on user input
	case $CHOOSE in
	1)
		# Addition
		echo "Enter the first number:"
		read -p "" NUM1
		# Validate if NUM1 is a number
		if [[ "$NUM1" =~ ^[0-9]+$ ]]; then
			echo "Enter the second number:"
			read -p "" NUM2
			# Validate if NUM2 is a number
			if [[ "$NUM2" =~ ^[0-9]+$ ]]; then
				RESULT=$((NUM1 + NUM2))
				echo "The result is $RESULT"
			else
				echo "Please enter a valid second number."
			fi
		else
			echo "Please enter a valid first number."
		fi
		;;
	2)
		# Subtraction
		echo "Enter the first number:"
		read -p "" NUM1
		if [[ "$NUM1" =~ ^[0-9]+$ ]]; then
			echo "Enter the second number:"
			read -p "" NUM2
			if [[ "$NUM2" =~ ^[0-9]+$ ]]; then
				RESULT=$((NUM1 - NUM2))
				echo "The result is $RESULT"
			else
				echo "Please enter a valid second number."
			fi
		else
			echo "Please enter a valid first number."
		fi
		;;
	3)
		# Multiplication
		echo "Enter the first number:"
		read -p "" NUM1
		if [[ "$NUM1" =~ ^[0-9]+$ ]]; then
			echo "Enter the second number:"
			read -p "" NUM2
			if [[ "$NUM2" =~ ^[0-9]+$ ]]; then
				RESULT=$((NUM1 * NUM2))
				echo "The result is $RESULT"
			else
				echo "Please enter a valid second number."
			fi
		else
			echo "Please enter a valid first number."
		fi
		;;
	4)
		# Division
		echo "Enter the first number:"
		read -p "" NUM1
		# Validate first number to ensure it is a valid positive integer
		if [[ "$NUM1" =~ ^[1-9]+$ ]]; then
			echo "Enter the second number:"
			read -p "" NUM2
			# Validate second number to ensure it's also a valid positive integer
			if [[ "$NUM2" =~ ^[1-9]+$ ]]; then
				RESULT=$((NUM1 / NUM2))
				echo "The result is $RESULT"
			else
				echo "Please enter a valid second number."
			fi
		else
			echo "Please enter a valid first number."
		fi
		;;
	5)
		# Square
		echo "Enter a number:"
		read -p "" NUM
		# Validate if NUM is a number
		if [[ "$NUM" =~ ^[0-9]+$ ]]; then
			RESULT=$((NUM * NUM))
			echo "The result is $RESULT"
		else
			echo "Please enter a valid number."
		fi
		;;
	6)
		# Square Root
		echo "Enter a number:"
		read -p "" NUM
		# Validate if NUM is a positive integer
		if [[ "$NUM" =~ ^[0-9]+$ ]]; then
			RESULT=$(echo "scale=2; sqrt($NUM)" | bc)
			echo "The result is $RESULT"
		else
			echo "Please enter a valid positive number."
		fi
		;;
	7)
		# Percentage
		echo "Enter a number:"
		read -p "" NUM
		# Validate if NUM is a number
		if [[ "$NUM" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
			RESULT=$(echo "$NUM * 100" | bc)
			echo "The result is $RESULT%"
		else
			echo "Please enter a valid number."
		fi
		;;
	8)
		# Exit the script
		echo "Exiting..."
		exit 0
		;;
	*)
		# Handle invalid input
		echo "Invalid option. Please select a valid operation."
		;;
	esac
done
