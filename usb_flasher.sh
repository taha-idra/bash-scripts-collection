#!/bin/bash
#
# Script Name: usb_flasher.sh
# Description: 
# This script is used to flash an ISO or IMG file to a USB device. 
# It allows users to select an image file (ISO/IMG) and a target device 
# (USB drive or any other storage device) and then writes the image to the device. 
#
# Usage: 
# 1. Make the script executable: chmod +x usb_flasher.sh 
# 2. Run the script: ./usb_flasher.sh or bash usb_flasher.sh
# 
# Author: Taha Idra
# Version: 0.1.0-alpha
# Date: 2024-12-18

# Variables
SOURCE_FILE=""       # The image file (ISO/IMG) to be flashed
TARGET_DEVICE=""     # The target device where the image will be written (e.g., /dev/sdX)
LOG_FILE="history.log"  # Log file to store the flashing operation details

# Function to select the image file
# This function prompts the user to input the full path to the image file (ISO/IMG).
# It checks if the file exists and whether it has a valid extension (.iso or .img).
select_image() {
    while [ -z "$SOURCE_FILE" ]; do 
        echo "Please enter the full path to the image file, e.g., /path/to/your.iso"
        read -p "" SOURCE_FILE
        
        # Check if the file exists and has a valid extension
        if [ -e "$SOURCE_FILE" ] && [[ "$SOURCE_FILE" == *.iso || "$SOURCE_FILE" == *.img ]]; then
            echo "File found: $SOURCE_FILE" 
        else
            echo "Error: The path entered is not valid or the file does not exist."
            SOURCE_FILE=""  # Reset the SOURCE_FILE if invalid input
        fi
    done
}

# Function to select the target device
# This function prompts the user to select a device path (e.g., /dev/sdX).
# It lists available devices using the `lsblk` command, and the user selects the device to flash.
select_drive() {
    while [ -z "$TARGET_DEVICE" ] || [[ "$TARGET_DEVICE" == */dev/ ]]; do
        echo "Show available devices:"
        echo "$(lsblk -e 7 -o NAME,TYPE,SIZE,MOUNTPOINT -p)"  # List available devices
        
        echo "Please choose or enter the device path, e.g., /dev/sdX"
        read -p "" TARGET_DEVICE
    done
}

# Function to perform the flashing operation
# This function uses the `dd` command to write the selected image file to the target device.
# It includes a safety prompt to confirm the operation and logs the progress.
flash() {
    # Warning message
    echo -e "\033[31mWarning: This will erase all data on the device. Are you sure you want to continue? (Y/N)\033[0m"
    local ANSWER=""
    read -p "" ANSWER
    
    # If user confirms, proceed with the flashing operation
    if [ $ANSWER = "Y" ] || [ $ANSWER = "y" ]; then
        echo -e "The operation is starting... \nPlease be patient as the device will be erased and flashed."
        
        # Perform the flashing using the dd command and log the output
        sudo dd if=$SOURCE_FILE of=$TARGET_DEVICE bs=4M status=progress | tee -a $LOG_FILE
        
        # Check if the flashing process was successful
        if [ $? -eq 0 ]; then
            echo "Flash completed successfully."
        else  
            echo "An error occurred during flashing."
        fi
    fi
}

# Run the functions sequentially
select_image
select_drive
flash 

