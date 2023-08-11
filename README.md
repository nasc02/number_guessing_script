# number_guessing_script

This repository contains a simple Bash script for a number guessing game, it is an obrigatory challenge to receive a certification in freeCodeCamp. The script interacts with a PostgreSQL database to track user information and game statistics. The game prompts users to guess a random number between 1 and 1000, providing feedback based on their guesses.

### Features

- Generates a random number between 1 and 1000 for users to guess.
- Utilizes a PostgreSQL database to store user information and game statistics.
- Asks users for their username and provides a personalized experience.
- Tracks the total number of games played by each user.
- Records the fewest number of guesses it took for a user to win a game.
- Supports both new users and returning users.
- Gives hints based on user input to help them guess the secret number.
- Handles non-integer inputs and prompts users to guess again.

### Setup Instructions

1. Clone this repository to your local machine.
2. Navigate to the `number_guessing_game` folder.
3. Make the `number_guess.sh` script executable: `chmod +x number_guess.sh`.
4. Install PostgreSQL if not already installed.
5. Create a PostgreSQL database using the provided dump or create your own structure based on the code provided in the dump, to use the dump you can type `psql -U postgres < number_guess.sql`
6. Run the `psql` command to connect to your PostgreSQL instance: `psql --username=freecodecamp --dbname=number_guess`.
7. Edit the script's PostgreSQL connection settings if needed, is the PSQL variable in the top of the script.
8. Run the script: `./number_guess.sh`.

### Usage

1. When prompted, enter your username.
2. If it's your first time playing, a welcome message will appear.
3. Guess the secret number between 1 and 1000.
4. Receive hints based on whether your guess is higher or lower than the secret number.
5. Continue guessing until you correctly guess the secret number.
6. After winning, the script will display the number of guesses it took you.
