#!/bin/bash

echo "Enter your age:"
read AGE

if [ $AGE -lt 18 ]
then
  echo "👶 Minor"
elif [ $AGE -ge 18 ] && [ $AGE -lt 60 ]
then
  echo "🧑 Adult"
else
  echo "👴 Senior Citizen"
fi

