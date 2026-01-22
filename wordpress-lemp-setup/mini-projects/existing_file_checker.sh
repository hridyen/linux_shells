#!/bin/bash

# Ask user for file name
read -p "Enter the file name: " filename

# Condition 1: File exists
if [ -f "$filename" ]; then

    # Sub-condition: Read permission available
    if [ -r "$filename" ]; then
        echo " File milgyiiiiiiii."
        echo "📄 File content:"
        echo "-------------------------"
        cat "$filename"
        echo "-------------------------"
    else
        echo "opps!!!!!!!!!!!!!! File exists but you do NOT have read permission."
    fi

# Condition 3: File does not exist
else
    echo "awwwwwwww File not found."
fi

