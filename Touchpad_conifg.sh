#!/bin/bash

# Function to check if libinput is installed
check_libinput_installed() {
    if ! dpkg -s libinput-bin >/dev/null 2>&1; then
        echo "libinput is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install libinput-bin
        echo "libinput installed successfully."
    fi
}

# Function to enable two-finger swipe for back navigation
enable_two_finger_swipe() {
    echo "Enabling two-finger swipe for back navigation..."
    xinput set-prop "$trackpad_device" "libinput Click Method Enabled" 0, 1
    xinput set-prop "$trackpad_device" "libinput Natural Scrolling Enabled" 0, 1
}

# Function to disable two-finger swipe for back navigation
disable_two_finger_swipe() {
    echo "Disabling two-finger swipe for back navigation..."
    xinput set-prop "$trackpad_device" "libinput Click Method Enabled" 0, 0
    xinput set-prop "$trackpad_device" "libinput Natural Scrolling Enabled" 0, 0
}

# Function to enable kinetic scrolling
enable_kinetic_scrolling() {
    echo "Enabling kinetic scrolling..."
    xinput set-prop "$trackpad_device" "libinput Scroll Method Enabled" 0, 0, 1
    xinput set-prop "$trackpad_device" "libinput Scroll Coasting Enabled" 0, 1
}

# Function to disable kinetic scrolling
disable_kinetic_scrolling() {
    echo "Disabling kinetic scrolling..."
    xinput set-prop "$trackpad_device" "libinput Scroll Method Enabled" 0, 0, 0
    xinput set-prop "$trackpad_device" "libinput Scroll Coasting Enabled" 0, 0
}

# Function to uninstall all changes
uninstall_changes() {
    echo "Uninstalling all changes..."
    xinput set-prop "$trackpad_device" "libinput Click Method Enabled" 0, 0
    xinput set-prop "$trackpad_device" "libinput Natural Scrolling Enabled" 0, 0
    xinput set-prop "$trackpad_device" "libinput Scroll Method Enabled" 0, 0, 0
    xinput set-prop "$trackpad_device" "libinput Scroll Coasting Enabled" 0, 0
}

# Main script logic

echo "Trackpad Configuration Script"

# Check if libinput is installed
check_libinput_installed

# List all input devices
echo "Available input devices:"
xinput list

# Prompt for trackpad selection
read -p "Enter the name or ID of the trackpad device: " trackpad_device

# Validate trackpad device
if ! xinput list-props "$trackpad_device" >/dev/null 2>&1; then
    echo "Invalid trackpad device. Exiting..."
    exit 1
fi

echo "Trackpad device selected: $trackpad_device"

while true; do
    echo ""
    echo "Please select an option:"
    echo "1. Enable two-finger swipe for back navigation"
    echo "2. Disable two-finger swipe for back navigation"
    echo "3. Enable kinetic scrolling"
    echo "4. Disable kinetic scrolling"
    echo "5. Uninstall all changes"
    echo "0. Exit"

    read -p "Enter your choice: " choice

    case $choice in
        1)
            enable_two_finger_swipe
            ;;
        2)
            disable_two_finger_swipe
            ;;
        3)
            enable_kinetic_scrolling
            ;;
        4)
            disable_kinetic_scrolling
            ;;
        5)
            uninstall_changes
            echo "All changes uninstalled."
            ;;
        0)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done

