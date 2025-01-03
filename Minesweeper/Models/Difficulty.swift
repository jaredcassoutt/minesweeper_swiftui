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
            return (rows: 16, columns: 16, mines: 40)
        case .hard:
            return (rows: 25, columns: 16, mines: 50)
        }
    }
}
