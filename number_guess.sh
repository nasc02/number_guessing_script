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

random_number=$(shuf -i 1-1000 -n 1)

GUESS_ATTEMPT(){
echo "Guess the secret number between 1 and 1000:"
read INPUT
}

NUMBER_OF_GUESSES=0
GUESS_ATTEMPT
if [[ $INPUT < $random_number ]]
then
  echo -e "\nIt's lower than that, guess again:\n"
  $NUMBER_OF_GUESSES+=1
  GUESS_ATTEMPT
else if [[ $INPUT > $random_number ]]
  echo -e "\nIt's higher than that, guess again:\n"
  $NUMBER_OF_GUESSES+=1
  GUESS_ATTEMPT
else if ! [[ "$INPUT" =~ ^[0-9]+$ ]]
  echo -e "\nThat is not an integer, guess again:\n"
  $NUMBER_OF_GUESSES+=1
  GUESS_ATTEMPT
else
  echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $random_number. Nice job!\n"
fi
