#!/bin/bash

# Script Name: usb_flasher.sh
# Description:
# Flash ISO/IMG files to USB devices
# Usage:
# 1. chmod +x usb_flasher.sh
# 2. ./usb_flasher.sh
# Author: Taha Idra
# Version: 0.1.1-alpha
# Date: 2025-01-02
# Variables
SOURCE_FILE=""       # Path to the image file (ISO/IMG)
TARGET_DEVICE=""     # Target device (e.g., /dev/sdX)
LOG_FILE="history.log" # Log file

while true; do
    echo "1) Select Image"
    echo "2) Select Drive"
    echo "3) Start Flashing"
    echo "4) Exit"
    read -p "Enter your choice: " CHOOSE

    case $CHOOSE in
    1)
        select_image() {
            while [ -z "$SOURCE_FILE" ]; do
                read -p "Enter the full path to the ISO/IMG file: " SOURCE_FILE
                if [ -e "$SOURCE_FILE" ] && [[ "$SOURCE_FILE" == *.iso || "$SOURCE_FILE" == *.img ]]; then
                    echo "Selected file: $SOURCE_FILE"
                else
                    echo "Invalid file. Please try again."
                    SOURCE_FILE=""
                fi
            done
        }
        select_image
        ;;

    2)
        select_drive() {
            while [ -z "$TARGET_DEVICE" ] || [[ "$TARGET_DEVICE" == "/dev/" ]]; do
                echo "Available devices:"
                lsblk -e 7 -o NAME,TYPE,SIZE,MOUNTPOINT -p
                read -p "Enter the device path (e.g., /dev/sdX): " TARGET_DEVICE
            done
        }
        select_drive
        ;;

    3)
        flash() {
            echo -e "\033[31mWarning: This will erase all data on $TARGET_DEVICE. Continue? (Y/N)\033[0m"
            read -p "Your choice: " ANSWER
            if [[ "$ANSWER" =~ ^[Yy]$ ]]; then
                echo "Flashing $SOURCE_FILE to $TARGET_DEVICE..."
                sudo dd if="$SOURCE_FILE" of="$TARGET_DEVICE" bs=4M status=progress | tee -a "$LOG_FILE"
                if [ $? -eq 0 ]; then
                    echo "Flash completed successfully."
                else
                    echo "Flashing failed. Check logs for details."
                fi
            else
                echo "Operation canceled."
            fi
        }
        flash
        ;;

    4)
        echo "Exiting..."
        exit 0
        ;;

    *)
        echo "Invalid choice. Please try again."
        ;;
    esac

done

