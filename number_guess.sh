#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=numberguessinggamedb -t --no-align -c"

echo "Enter your username:"
read USERNAME

USERNAME_DATABASE=$($PSQL "SELECT name FROM users WHERE name = $USERNAME")

if [[ -z $USERNAME_DATABASE ]]
then
 echo "Welcome, $USERNAME! It looks like this is your first time here."
 $($PSQL "INSERT INTO users(name) VALUES($USERNAME)")
else
  Welcome back, $USERNAME_DATABASE! You have played <games_played> games, and your best game took <best_game> guesses. #TODO
fi

echo "Guess the secret number between 1 and 1000:"
read INPUT