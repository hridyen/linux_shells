#!/bin/bash

echo "Enter a number (1-3):"
read choice

case $choice in
  1)
    echo "You chose ONE"
    ;;
  2)
    echo "You chose TWO"
    ;;
  3)
    echo "You chose THREE"
    ;;
  *)
    echo "Invalid choice"
    ;;
esac

