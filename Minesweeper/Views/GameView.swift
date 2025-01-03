//
//  GameView.swift
//  Minesweeper
//
//  Created by Jared Cassoutt on 1/1/25.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    
    let difficulty: Difficulty
    @StateObject var viewModel: GameViewModel
    
    @State private var showConfetti = false
    @State private var showShareSheet = false
    @State private var presentGameOverView = false
    
    init(difficulty: Difficulty) {
        self.difficulty = difficulty
        _viewModel = StateObject(wrappedValue: GameViewModel(difficulty: difficulty))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            VStack(alignment: .center, spacing: 0) {
                titleText
                timerText
                controlButtons
                mineSweeperGrid
            }
            if viewModel.isGameOver {
                gameOverOverlay
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
            viewModel.newGame(difficulty: difficulty)
        }
        .sheet(isPresented: $showShareSheet) {
            ActivityViewController(activityItems: [
                "I just completed a Minesweeper on \(difficulty.rawValue) difficulty in only \(viewModel.timerString)! Try to beat my time!"
            ])
        }
        .onReceive(viewModel.$isGameOver) { isCompleted in
            if isCompleted && viewModel.isVictory {
                showConfetti = true
            }
        }
        .displayConfetti(isActive: $showConfetti)
    }
    
    private var titleText: some View {
        Text("\(difficulty.rawValue) Puzzle")
            .font(.system(size: 30, weight: .bold, design: .rounded))
            .bold()
            .padding([.top, .horizontal])
    }
    
    private var timerText: some View {
        Text(viewModel.timerString)
            .font(.subheadline)
            .padding(.bottom)
    }
    
    private var controlButtons: some View {
        HStack {
            Spacer()
            flagButton
            Spacer()
            hintButton
            Spacer()
            restartButton
            Spacer()
        }
        .padding(.bottom)
    }
    
    private var flagButton: some View {
        Button(action: {
            viewModel.toggleFlagMode()
        }) {
            VStack {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "flag")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundColor(.text1)
                        .padding()
                        .background(
                            viewModel.isFlagMode
                                ? Color.accentColor.opacity(0.2)
                                : Color.gray.opacity(0.2)
                        )
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    viewModel.isFlagMode ? Color.accentColor : Color.clear,
                                    lineWidth: 2
                                )
                        )
                    if viewModel.isFlagMode {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 16, height: 16)
                            .overlay(
                                Text("ON")
                                    .font(.system(size: 8))
                                    .foregroundColor(.white)
                            )
                            .offset(x: 8, y: -8)
                    }
                }
                Text("Flag")
                    .font(.caption)
                    .foregroundColor(.text1)
            }
        }
    }
    
    private var hintButton: some View {
        Button(action: {
            viewModel.provideHint()
        }) {
            VStack {
                Image(systemName: "brain")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                    .foregroundColor(.text1)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                Text("Hint")
                    .font(.caption)
                    .foregroundColor(.text1)
            }
        }
    }
    
    private var restartButton: some View {
        Button(action: {
            viewModel.restartPuzzle()
            showConfetti = false
        }) {
            VStack {
                Image(systemName: "arrow.counterclockwise.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                    .foregroundColor(.text1)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                Text("Restart")
                    .font(.caption)
                    .foregroundColor(.text1)
            }
        }
    }
    
    private var mineSweeperGrid: some View {
        GeometryReader { geometry in
            let rowCount = viewModel.rows
            let colCount = viewModel.columns

            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height

            let cellWidth = screenWidth / CGFloat(colCount)
            let cellHeight = screenHeight / CGFloat(rowCount)
            let cellSize = min(cellWidth, cellHeight)

            VStack(spacing: 0) {
                ForEach(0..<rowCount, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<colCount, id: \.self) { col in
                            if let cell = viewModel.grid[safe: row]?[safe: col] {
                                CellView(cell: cell) {
                                    viewModel.revealCell(row: row, col: col)
                                } onLongPress: {
                                    viewModel.toggleFlag(row: row, col: col)
                                }
                                .frame(width: cellSize, height: cellSize)
                            } else {
                                EmptyView()
                                    .frame(width: cellSize, height: cellSize)
                            }
                        }
                    }
                }
            }
            .frame(width: screenWidth, height: screenHeight)
        }
        .padding()
    }
    
    private var gameOverOverlay: some View {
        ZStack {
            Rectangle()
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                GameOverView(
                    isVictory: $viewModel.isVictory,
                    completionTime: $viewModel.timerString,
                    onNewGame: {
                        dismiss()
                    },
                    onContinue: {
                        viewModel.isGameOver = false
                    },
                    onRestart: {
                        viewModel.newGame(difficulty: difficulty)
                        viewModel.isGameOver = false
                        showConfetti = false
                    },
                    onShare: {
                        showShareSheet = true
                    }
                )
                Spacer()
            }
        }
    }
    
    private var backButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .padding()
                .foregroundColor(.text1)
                .background(Color.background2)
                .clipShape(Circle())
        })
    }
}
