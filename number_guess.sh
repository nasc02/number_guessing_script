#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "Enter your username:" 
read USERNAME

USERNAME_DATABASE=$($PSQL "SELECT name FROM users WHERE name = '$USERNAME'")

if [[ -z $USERNAME_DATABASE ]]; then
  if [[ -n "$USERNAME" && ! "$USERNAME" =~ ^[[:space:]]+$ ]]; then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    INSERT_USERNAME=$($PSQL "INSERT INTO users(name) VALUES('$USERNAME')")
    USERNAME_DATABASE=$($PSQL "SELECT name FROM users WHERE name = '$USERNAME'")
    FIRST_GAME_INSERT=$($PSQL "UPDATE users SET games_played=1 WHERE name='$USERNAME'")
  else
    echo "Invalid username."
    exit 1
  fi
else
  NUMBER_OF_GAMES=$($PSQL "SELECT games_played FROM users WHERE name='$USERNAME'")
  BEST_GAME_GUESSES=$($PSQL "SELECT best_game_guesses FROM users WHERE name = '$USERNAME'")
  echo "Welcome back, $USERNAME_DATABASE! You have played $NUMBER_OF_GAMES games, and your best game took $BEST_GAME_GUESSES guesses." #TODO
  GAME_INSERT=$($PSQL "UPDATE users SET games_played=$NUMBER_OF_GAMES + 1 WHERE name='$USERNAME_DATABASE'")
fi

RANDOM_NUMBER=$(shuf -i 1-1000 -n 1)

GUESS_ATTEMPT(){
echo "Guess the secret number between 1 and 1000:"
read INPUT
}

GUESS_ATTEMPT

NUMBER_OF_GUESSES=1
BEST_GAME_GUESSES=$($PSQL "SELECT best_game_guesses FROM users WHERE name = '$USERNAME'")

while true; do
if ! [[ "$INPUT" =~ ^[0-9]+$ ]]; then
  echo -e "\nThat is not an integer, guess again:\n"
  NUMBER_OF_GUESSES=$(($NUMBER_OF_GUESSES + 1))
  GUESS_ATTEMPT
elif [[ $INPUT -gt $RANDOM_NUMBER ]]; then
  echo -e "\nIt's lower than that, guess again:\n"
  NUMBER_OF_GUESSES=$(($NUMBER_OF_GUESSES + 1))
  GUESS_ATTEMPT
elif [[ $INPUT -lt $RANDOM_NUMBER ]]; then
  echo -e "\nIt's higher than that, guess again:\n"
  NUMBER_OF_GUESSES=$(($NUMBER_OF_GUESSES + 1))
  GUESS_ATTEMPT
else
  if [[ $NUMBER_OF_GUESSES -lt $BEST_GAME_GUESSES || -z $BEST_GAME_GUESSES ]]; then
    UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game_guesses = $NUMBER_OF_GUESSES WHERE name='$USERNAME_DATABASE'")
  fi
  echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $RANDOM_NUMBER. Nice job!\n"
  exit 0
fi
done
