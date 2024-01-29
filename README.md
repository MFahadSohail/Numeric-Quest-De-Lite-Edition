# Numeric-Quest-De-Lite-Edition

Number Guessing Game on DE-10 Lite Board
Project Description:
The project is a number-guessing game designed for the DE-10 Lite Board. In this game, the user's objective is to guess a randomly generated number between 1 and 15. The user inputs their guesses using the 4 switches on the DE-10 Lite Board. The game allows the user three attempts or a time limit of 20 seconds to guess the correct number. The outcome of the game, whether the user wins or loses, is displayed as "u wIn" or "u LOSE" on the DE-10 Lite Board.

Logic Explanation:
The project incorporates both Combinational and Sequential Logic to handle various aspects of the game. Combinational Logic is employed to calculate and display the outcomes ("u wIn" or "u LOSE") on the 7-segment Hex displays based on user inputs and the game state. The logic involves multiple if-else statements to check if the user's input matches the randomly generated number stored in memory.

The user inputs their guesses using the switches on the DE-10 Lite Board, representing numbers in binary format. For instance, if the user wants to guess 7, they would input "0111" through the switches.

Sequential Logic is utilized to maintain the internal state of the game, including tracking the timer and the number of attempts. Registers (reg) and Clocks (clk) play a crucial role in the implementation.

Testable Features:
The project provides several testable features to demonstrate its functionality:

Reset Button: Clicking the reset button resets the game and timer.

7-segment Hex Displays: The displays show messages such as "u wIn" or "u LOSE" based on the game outcome.

User Inputs: Users can input their guesses using the switches on the DE-10 Lite Board.

Timer: The timer counts down, giving the user 20 seconds to make their guesses.

LED Indicators: LEDs indicate the number of attempts remaining.

Getting Started:
To run the project on your DE-10 Lite Board, follow these steps:

Hardware Setup: Connect the DE-10 Lite Board to your computer.

Programming: Program the DE-10 Lite Board with the provided code.

Gameplay: Use the switches to input your guesses. The 7-segment Hex displays will show the outcome, and LED indicators will display the number of attempts remaining.

Reset: Press the reset button to start a new game.

Dependencies:
This project requires the DE-10 Lite Board and associated development tools.

Acknowledgments:
This project was developed in EECS 3201 course.

Feel free to reach out for any questions or support!
