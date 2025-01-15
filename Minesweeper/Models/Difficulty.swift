//
//  Difficulty.swift
//  Minesweeper
//
//  Created by Jared Cassoutt on 1/1/25.
//

import Foundation

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var gridSize: (rows: Int, columns: Int, mines: Int) {
        switch self {
        case .easy:
            return (rows: 9, columns: 9, mines: 10)
        case .medium:
            return (rows: 18, columns: 12, mines: 30)
        case .hard:
            return (rows: 25, columns: 16, mines: 50)
        }
    }
}
