//
//  MinesweeperCellView.swift
//  Minesweeper
//
//  Created by Jared Cassoutt on 1/1/25.
//

//
//  MinesweeperCellView.swift
//  Minesweeper
//
//  Created by Jared Cassoutt on 1/1/25.
//

import SwiftUI

struct MinesweeperCellView: View {
    let cell: MinesweeperCell
    
    /// Called when the user taps (left-click) on the cell
    let onTap: () -> Void
    
    /// Called when the user long-presses (right-click / flag) the cell
    let onLongPress: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                .fill(cell.isRevealed ? Color.background1 : Color.background3)
                .border(Color.background2, width: 1)
            
            if cell.isRevealed {
                if cell.isMine {
                    Text("💣")
                        .font(.system(size: 20))
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                } else if cell.adjacentMines > 0 {
                    Text("\(cell.adjacentMines)")
                        .font(.system(size: 16).bold())
                        .foregroundColor(colorForAdjacentMines(cell.adjacentMines))
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                }
            } else {
                // If not revealed
                if cell.isFlagged {
                    Text("🚩")
                        .font(.system(size: 16))
                }
            }
        }
        .onTapGesture {
            onTap()
        }
        .onLongPressGesture {
            onLongPress()
        }
    }
    
    private func colorForAdjacentMines(_ count: Int) -> Color {
        switch count {
        case 1: return .blue
        case 2: return .green
        case 3: return .red
        case 4: return .purple
        default: return .black
        }
    }
}
