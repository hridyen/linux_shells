#!/bin/bash

clear

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " GREATER NUMBER FINDER "
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo

# Read numbers 
read -p "Enter first number: " num1
read -p "Enter second number: " num2

echo

# Validate
if ! [[ "$num1" =~ ^-?[0-9]+$ && "$num2" =~ ^-?[0-9]+$ ]]; then
    echo "❌ Bhai number daal, calculator hai teri roughcopy nhi"
    exit 1
fi

# Compare
if [ "$num1" -gt "$num2" ]; then
    echo "Greater number is: $num1"
elif [ "$num1" -lt "$num2" ]; then
    echo " Greater number is: $num2"
else
    echo " Both numbers are equal"
fi

echo
echo "✔️ Comparison completed successfully."

