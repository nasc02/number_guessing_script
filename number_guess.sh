#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "Enter your username:" 
read USERNAME

USERNAME_DATABASE=$($PSQL "SELECT name FROM users WHERE name = '$USERNAME'")

if [[ -z $USERNAME_DATABASE ]]; then
  if [[ -n "$USERNAME" && ! "$USERNAME" =~ ^[[:space:]]+$ ]]; then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    INSERT_USERNAME=$($PSQL "INSERT INTO users(name) VALUES('$USERNAME')")
  else
    echo "Invalid username."
    exit 0
  fi
else
  echo "Welcome back, $USERNAME_DATABASE! You have played <games_played> games, and your best game took <best_game> guesses." #TODO
fi

RANDOM_NUMBER=$(shuf -i 1-1000 -n 1)

GUESS_ATTEMPT(){
echo "Guess the secret number between 1 and 1000:"
read INPUT
}

echo $RANDOM_NUMBER #test

NUMBER_OF_GUESSES=1
GUESS_ATTEMPT
while true; do
if [[ $INPUT -gt $RANDOM_NUMBER ]]; then
  echo -e "\nIt's lower than that, guess again:\n"
  NUMBER_OF_GUESSES=$(($NUMBER_OF_GUESSES + 1))
  GUESS_ATTEMPT
elif [[ $INPUT -lt $RANDOM_NUMBER ]]; then
  echo -e "\nIt's higher than that, guess again:\n"
  NUMBER_OF_GUESSES=$(($NUMBER_OF_GUESSES + 1))
  GUESS_ATTEMPT
elif ! [[ "$INPUT" =~ ^[0-9]+$ ]]; then
  echo -e "\nThat is not an integer, guess again:\n"
  NUMBER_OF_GUESSES=$(($NUMBER_OF_GUESSES + 1))
  GUESS_ATTEMPT
else
  echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $RANDOM_NUMBER. Nice job!\n"
  break
fi
done
