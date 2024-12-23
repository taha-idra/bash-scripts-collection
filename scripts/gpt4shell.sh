#!/bin/bash

# Script Name: gpt4shell.sh
# Description:
# This script allows users to chat with OpenAI's GPT model via the command line. 
# It lets users send messages, view chat history, change settings, and exit the program. 
# All chats and errors are logged.
#
# Usage:
# 1. Make the script executable: chmod +x gpt4shell.sh
# 2. Run the script: ./gpt4shell.sh or bash gpt4shell.sh
#
# Author: Taha Idra
# Version: 0.1.0-alpha
# Date: 2024-12-22

# Variables
API_KEY="your-api-key"                               # API Key for authentication with OpenAI
API_URL="https://api.openai.com/v1/chat/completions" # The API endpoint URL for making requests to OpenAI's chat model
MODEL="gpt-4o-mini"                                  # Model identifier for the OpenAI model used in requests
MODEL_NAME="ChatGPT"                                 # A name for the model to display in responses
USER_NAME="You"                                      # A name for the model to display in responses
CHAT_HISTORY="history.txt"                           # Path to the file where chat history is saved
LOG_FILE="gpt4shell.log"                             # Path to the file where errors and logs are saved

# Main loop
while true; do
	echo "Welcome to GPT4Shell!"
	echo "1) Chat"
	echo "2) Chat History"
	echo "3) Settings"
	echo "4) Exit"
	echo ""
	echo -n "Choose an option: "
	read CHOOSE

	case $CHOOSE in
	# Option 1: Start chat
	1)

		chat() { # Handles the interactive chat with the model.
			while true; do
				echo "Type 'e' or 'E' to end the chat"
				echo -n "Send a message:"
				read -p "" PROMPT
				# Check if the prompt is empty
				if [ -z "$PROMPT" ]; then
					echo -e "You must enter something!"
					# Check if the user wants to exit the chat
				elif [[ "$PROMPT" == "E" ]] || [[ "$PROMPT" == "e" ]]; then
					break
				else
					# Send the user message to the OpenAI API and store the response
					RESPONSE=$(curl -s -X POST "$API_URL" \
						-H "Content-Type: application/json" \
						-H "Authorization: Bearer $API_KEY" \
						-d "{\"model\": \"$MODEL\", \"messages\": [{\"role\": \"user\", \"content\": \"$PROMPT\"}]}")
					# Check if the API request failed
					if [ $? -ne 0 ]; then
						echo -e "\033[0;31mError! Failed to connect to the API\033[0m: $(date)" | tee -a $LOG_FILE
					else
						# Save the user input and the model's response to the chat history file
						echo "$USER_NAME sent: $PROMPT" | tee -a $CHAT_HISTORY
						echo -en "$MODEL_NAME Reply: " | tee -a $CHAT_HISTORY
						echo "$RESPONSE" | jq -r '.choices[0].message.content' | tee -a $CHAT_HISTORY || echo -e "\033[0;31mError! Invalid response from API\033[0m: $(date)" | tee -a $LOG_FILE
					fi
				fi
			done
		}
		chat # Call the chat function
		;;
		# Option 2: View chat history
	2)
		chat_history() {   # Function to display chat history
			cat $CHAT_HISTORY # show the Chat History
		}
		chat_history # Call the chat_history function
		;;
		# Option 3: Settings
	3)
		settings() { # Function to handle settings updates
			while true; do
				echo "Settings"
				echo "1) Change API key"
				echo "2) Change API URL"
				echo "3) Change Model"
				echo "4) Change Model name"
				echo "5) Change User name"
				echo ""
				echo "Type 'e' or 'E' to end the chat"
				echo -n "Choose a Setting option:"
				read CHOOSE_SETTINGS

				case $CHOOSE_SETTINGS in

				1)
					echo -n "Enter your New API Key or Copy it: "
					read -p "" API_KEY
					;;
				2)
					echo -n "Enter your New API URL or Copy it: "
					read -p "" API_URL
					;;
				3)
					echo -n "Enter your New Model or Copy it: "
					read -p "" MODEL
					;;
				4)
					echo -n "Enter your New Model name: "
					read -p "" MODEL_NAME
					;;
				5)
					echo -n "Enter your New User name: "
					read -p "" USER_NAME
					;;
				e)
					break
					;;

				E)
					break
					;;
				*)
					echo "Invalid input. Please try again"
					;;
				esac
			done
		}

		settings # Call the settings function
		;;
		# Option 4: Exit the program
	4)
		exit 0
		;;
		# Invalid option
	*)
		echo "Invalid input. Please try again"
		;;
	esac
done
