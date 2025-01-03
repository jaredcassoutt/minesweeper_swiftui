# SwiftUI MineSweeper Game
A full-featured Minesweeper game built with SwiftUI, offering multiple difficulty levels and an engaging, user-friendly design. This app brings the classic puzzle game to life, complete with flagging mode, hints, and a confetti celebration for successful completions!

## Preview
<p align="center"> <img src="https://github.com/user-attachments/assets/7c69bf29-b33f-40fb-b20a-82f1f8358e63" alt="Sudoku Game Preview" width="300"> </p>

## Features
- Three Difficulty Levels: Choose from Easy, Medium, and Hard to match your puzzle-solving skills.
- Interactive Minesweeper Grid: Tap to reveal tiles, flag potential mines, and navigate the game intuitively.
- Game Center Integration: Track your scores on the leaderboard and compete with others to achieve the fastest times.
- Confetti Celebration: Enjoy a vibrant confetti animation when you successfully clear a board!
- Flagging Mode and Hints: Switch to flagging mode to mark potential mines or use hints to guide your next move.
- Restart and New Game Options: Start over or dive into a new game at any time for endless fun.

## Getting Started
1. Clone the Repository:
   ```bash
    git clone https://github.com/jaredcassoutt/minesweeper_swiftui.git

2. Open the Project in Xcode:
    - Open Minesweeper.xcodeproj in Xcode.
    - Make sure you’re running Xcode 12 or later.
3. Run the App:
    - Build and run on the simulator or an actual device.
    - Select a difficulty level and start solving puzzles!

## How It Works
The project is organized into several key components:

- **GameView.swift:** The main game screen, displaying the Minesweeper grid and handling user interactions.
- **GameViewModel.swift:** The engine that generates new puzzles with unique solutions, adjustable by difficulty.
- **GameCenterHelper.swift:** Manages Game Center authentication and leaderboard score submissions.
- **ConfettiView.swift:** Displays a celebratory confetti animation when a puzzle is completed.

## Future Enhancements
- **Daily Challenges:** Add a daily board for players to compete on a global leaderboard.
- **Sound Effects and Animations:** Add subtle sound effects and more animations to enhance the user experience.

## Contributing
Feel free to fork the project, submit issues, or suggest improvements. Feedback and ideas for new features are welcome!

## License

This project is open-source under the MIT License.

Thanks for checking out my SwiftUI Minesweeper game! Dive into the code, solve some puzzles, and see if you can beat your own high scores.
