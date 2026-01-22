#!/bin/bash

NUM=$((RANDOM % 10 + 1))

echo "Guess a number between 1 to 10"
read GUESS

if [ $GUESS -eq $NUM ]
then
  echo "7 croreeeeeee"
else
  echo " Wrong! Number was $NUM"
fi

