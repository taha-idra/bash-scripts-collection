#!/bin/bash
#
# Script Name: backup.sh
# Description: This script performs backups between local and remote directories using rsync.
#
# Usage:
# 1. Make the script executable: chmod +x backup.sh
# 2. Run the script: ./backup.sh or bash backup.sh
#
# Author: Taha Idra
# Version: 0.1.0-alpha
# Date: 2024-12-21

LOG_FILE="backup.log" # Log file to store the status of the backups

# Log file to store the status of the backups
while true; do

	# Display menu options
	echo "Choose a backup option:"
	echo "1) local to local"  # Backup from local directory to another local directory
	echo "2) local to remote" # Backup from a local directory to a remote server
	echo "3) remote to local" # Backup from a remote server to a local directory
	echo "4) Exit"

	# Read the user's choice
	read CHOOSE

	# Handle the user's choice using a case statement
	case $CHOOSE in

	1) # Option 1: Local to local backup
		local_tolocal() {
			local SOURCE_DIR
			local DESTINATION_DIR

			echo "Enter the source: e.g., /path/to/source"
			read SOURCE_DIR

			# Check if source directory is provided and exists
			if [ -n "$SOURCE_DIR" ] && [ -e "$SOURCE_DIR" ]; then # if 1

				echo "Enter the destination: e.g., /path/to/destination"
				read DESTINATION_DIR
				# Check if destination directory is provided and exists
				if [ -n "$DESTINATION_DIR" ] && [ -e "$DESTINATION_DIR" ]; then # if 2
					# Perform the backup using rsync
					rsync -azv --progress "$SOURCE_DIR" "$DESTINATION_DIR" >"$LOG_FILE" 2>&1
					if [ $? -eq 0 ]; then # if 3

						echo -e "\033[0;32mBackup successful:\033[0;32m $(date)" | tee -a "$LOF_FILE"

					else # else if 3

						echo -e "\033[0;31mBackup failed:\033[0m $(date)" | tee -a "$LOG_FILE"

					fi  # End if 3
				else # else if 2

					echo -e "\033[0;31mError!\033[0m \nThe destination does not exist, or you did not specify any input."

				fi  # End if 2
			else # else if 1

				echo -e "\033[0;31mError!\033[0m \nThe source does not exist, or you did not specify any input."

			fi # End if 1
		}
		local_tolocal
		;;

	2) # Option 2: Local to remote backup
		local_toremote() {
			local SOURCE_DIR
			local DESTINATION_DIR
			local USER_REMOTEHOST

			echo "Enter the User and Remote Host: e.g., root@192.168.5.219"
			read USER_REMOTEHOST
			# Validate the remote user and host input
			if [ -z "$USER_REMOTEHOST" ]; then # if 1

				echo -e "Enter the source and destination: e.g., /path/to/your/source /path/to/your/destination\n\033[0;33mNOTE:\033[0;33m Make sure to leave a space between the source and destination inputs, as shown in the example."
				read SOURCE_DIR DESTINATION_DIR
				# Validate source and destination inputs
				if [ -n "$SOURCE_DIR" ] && [ -e "$SOURCE_DIR" ] && [ -n "$DESTINATION_DIR" ] && [ -e "$DESTINATION_DIR" ]; then # if 2
					# Perform the backup using rsync
					rsync -azv --progress "$SOURCE" "$USER_REMOTEHOST":"$DESTINATION_DIR" >"$LOG_FILE" 2>&1
					if [ $? -eq 0 ]; then # if 3

						echo -e "\033[0;32mBackup successful:\033[0;32m $(date) " | tee -a "$LOF_FILE"

					else # else if 3

						echo -e "\033[0;31mBackup failed:\033[0m $(date)" | tee -a "$LOG_FILE"

					fi  # End if 3
				else # else if 2

					echo -e "\033[0;31mError!\033[0m \nEither the source, the destination, or both do not exist, or you did not specify any input."

				fi  # End if 2
			else # else if 1

				echo -e "\033[0;31mError!\033[0m \nThe remote host or user is incorrect."

			fi # End if 1
		}
		local_toremote
		;;

	3) # Option 3: Remote to local backup
		remote_tolocal() {
			local SOURCE_DIR
			local DESTINATION_DIR
			local USER_REMOTEHOST

			echo "Enter the User and Remote Host: e.g., root@192.168.5.219"
			read USER_REMOTEHOST
			# Validate the remote user and host input
			if [ -z "$USER_REMOTEHOST" ] && [ -e "$USER_REMOTEHOST" ]; then # if 1

				echo -e "Enter the source and destination: e.g., /path/to/your/source /path/to/your/destination\n\033[0;33mNOTE:\033[0;33m Make sure to leave a space between the source and destination inputs, as shown in the example."
				read SOURCE_DIR DESTINATION_DIR
				# Validate source and destination inputs
				if [ -n "$SOURCE_DIR" ] && [ -e "$SOURCE_DIR" ] && [ -n "$DESTINATION_DIR" ] && [ -e "$DESTINATION_DIR" ]; then # if 2
					# Perform the backup using rsync
					rsync -azv --progress "$USER_REMOTEHOST":"$SOURCE_DIR" "$DESTINATION_DIR" >"$LOG_FILE" 2>&1
					if [ $? -eq 0 ]; then # if 3

						echo -e "\033[0;32mBackup successful:\033[0;32m $(date) " | tee -a "$LOF_FILE"

					else # else if 3

						echo -e "\033[0;31mBackup failed:\033[0m $(date)" | tee -a "$LOG_FILE"

					fi  # End if 3
				else # else if 2

					echo -e "\033[0;31mError!\033[0m \nEither the source, the destination, or both do not exist, or you did not specify any input."

				fi  # End if 2
			else # else if 1

				echo -e "\033[0;31mError!\033[0m \nThe remote host or user is incorrect."

			fi # End if 1
		}
		remote_tolocal
		;;

	4) # Option 4: Exit the script

		exit 0

		;;

	*) # Invalid input
		echo -e "\033[0;31mError input!\033[0m \n please try again"
		;;

	esac

done
