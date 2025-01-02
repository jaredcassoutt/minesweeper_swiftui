//
//  MinesweeperCell.swift
//  Minesweeper
//
//  Created by Jared Cassoutt on 1/1/25.
//

import Foundation

/// Represents a single cell in the Minesweeper grid.
class MinesweeperCell: ObservableObject, Identifiable {
    let id = UUID()
    
    @Published var isMine: Bool = false
    @Published var isRevealed: Bool = false
    @Published var isFlagged: Bool = false
    @Published var adjacentMines: Int = 0
}
