//
//  MinesweeperViewModel.swift
//  Minesweeper
//
//  Created by Jared Cassoutt on 1/1/25.
//

import SwiftUI
import Combine

class MinesweeperViewModel: ObservableObject {
    @Published var grid: [[MinesweeperCell]] = []
    @Published var isGameOver: Bool = false
    @Published var isVictory: Bool = false
    
    private(set) var currentDifficulty: MinesweeperDifficulty
    
    @Published var isFlagMode: Bool = false
    
    // Timer
    @Published var timerString: String = "00:00"
    private var timer: AnyCancellable?
    private var startTime: Date?
    private var isTimerRunning = false
    
    // Board dimensions
    var rows: Int
    var columns: Int
    var totalMines: Int
    
    init(difficulty: MinesweeperDifficulty) {
        self.currentDifficulty = difficulty
        self.rows = difficulty.gridSize.rows
        self.columns = difficulty.gridSize.columns
        self.totalMines = difficulty.gridSize.mines
    }
    
    func newGame(difficulty: MinesweeperDifficulty) {
        // Stop any existing timer
        stopTimer()
        
        self.currentDifficulty = difficulty
        
        // Update board size & mine count for the new difficulty
        let size = difficulty.gridSize
        self.rows = size.rows
        self.columns = size.columns
        self.totalMines = size.mines
        
        // Create fresh grid
        grid = createEmptyGrid(rows: rows, columns: columns)
        
        // Place mines
        placeMines(count: totalMines)
        
        // Calculate adjacent mines
        calculateAdjacentMines()
        
        isGameOver = false
        isVictory = false
        
        // Start timer
        startTimer()
    }
    
    // MARK: - Flag Mode
    
    func toggleFlagMode() {
        isFlagMode.toggle()
    }
    
    // MARK: - Hint
    
    /// Automatically flags one random unrevealed mine (if any are available).
    func provideHint() {
        // Get a list of unrevealed, unflagged mines
        var candidateCells: [(row: Int, col: Int)] = []
        
        for r in 0..<rows {
            for c in 0..<columns {
                let cell = grid[r][c]
                if cell.isMine && !cell.isRevealed && !cell.isFlagged {
                    candidateCells.append((r, c))
                }
            }
        }
        
        guard !candidateCells.isEmpty else { return }
        
        // Randomly pick one of the candidate cells and flag it
        let randomIndex = Int.random(in: 0..<candidateCells.count)
        let (row, col) = candidateCells[randomIndex]
        grid[row][col].isFlagged = true
        
        // You might check for victory after the hint
        checkVictory()
    }
    
    // MARK: - Restart
    
    func restartPuzzle() {
        newGame(difficulty: currentDifficulty)
    }
    
    // MARK: - Game Logic
    
    /// Adjust reveal logic: if in flag mode, place a flag instead of revealing.
    func revealCell(row: Int, col: Int) {
        guard !isGameOver else { return }
        guard isValid(row, col) else { return }
        
        // If in flag mode, place a flag instead of revealing
        if isFlagMode {
            toggleFlag(row: row, col: col)
            return
        } else {
            // If flagged already, ignore
            if grid[row][col].isFlagged { return }
        }
        
        // Normal reveal logic below
        grid[row][col].isRevealed = true
        
        if grid[row][col].isMine {
            isGameOver = true
            isVictory = false
            stopTimer()
            revealAllMines()
            return
        }
        
        if grid[row][col].adjacentMines == 0 {
            revealNeighbors(row: row, col: col)
        }
        
        checkVictory()
    }
    
    func toggleFlag(row: Int, col: Int) {
        guard !isGameOver else { return }
        guard isValid(row, col) else { return }
        guard !grid[row][col].isRevealed else { return }
        
        grid[row][col].isFlagged.toggle()
        
        checkVictory()
    }
    
    private func checkVictory() {
        var revealedCount = 0
        var correctFlags = 0
        
        for row in 0..<rows {
            for col in 0..<columns {
                let cell = grid[row][col]
                if cell.isRevealed && !cell.isMine {
                    revealedCount += 1
                }
                if cell.isFlagged && cell.isMine {
                    correctFlags += 1
                }
            }
        }
        
        let totalNonMines = rows * columns - totalMines
        
        if revealedCount == totalNonMines || correctFlags == totalMines {
            isGameOver = true
            isVictory = true
            stopTimer()
            revealAllMines()
        }
    }
    
    private func revealAllMines() {
        for row in 0..<rows {
            for col in 0..<columns {
                if grid[row][col].isMine {
                    grid[row][col].isRevealed = true
                }
            }
        }
    }
    
    private func revealNeighbors(row: Int, col: Int) {
        for dr in -1...1 {
            for dc in -1...1 {
                let r = row + dr
                let c = col + dc
                if isValid(r, c), !grid[r][c].isRevealed, !grid[r][c].isMine {
                    revealCell(row: r, col: c)
                }
            }
        }
    }
    
    // MARK: - Setup Grid
    
    private func createEmptyGrid(rows: Int, columns: Int) -> [[MinesweeperCell]] {
        var result: [[MinesweeperCell]] = []
        for _ in 0..<rows {
            var rowArr: [MinesweeperCell] = []
            for _ in 0..<columns {
                rowArr.append(MinesweeperCell())
            }
            result.append(rowArr)
        }
        return result
    }
    
    private func placeMines(count: Int) {
        var placed = 0
        while placed < count {
            let r = Int.random(in: 0..<rows)
            let c = Int.random(in: 0..<columns)
            if !grid[r][c].isMine {
                grid[r][c].isMine = true
                placed += 1
            }
        }
    }
    
    private func calculateAdjacentMines() {
        for r in 0..<rows {
            for c in 0..<columns {
                if !grid[r][c].isMine {
                    let mineCount = countMinesAround(row: r, col: c)
                    grid[r][c].adjacentMines = mineCount
                }
            }
        }
    }
    
    private func countMinesAround(row: Int, col: Int) -> Int {
        var count = 0
        for dr in -1...1 {
            for dc in -1...1 {
                let nr = row + dr
                let nc = col + dc
                if isValid(nr, nc), grid[nr][nc].isMine {
                    count += 1
                }
            }
        }
        return count
    }
    
    private func isValid(_ row: Int, _ col: Int) -> Bool {
        (0..<rows).contains(row) && (0..<columns).contains(col)
    }
    
    // MARK: - Timer
    
    private func startTimer() {
        startTime = Date()
        isTimerRunning = true
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
    }
    
    private func stopTimer() {
        isTimerRunning = false
        timer?.cancel()
        timer = nil
    }
    
    private func updateTimer() {
        guard isTimerRunning, let startTime = startTime else { return }
        
        let elapsed = Int(Date().timeIntervalSince(startTime))
        let minutes = elapsed / 60
        let seconds = elapsed % 60
        timerString = String(format: "%02d:%02d", minutes, seconds)
    }
}
