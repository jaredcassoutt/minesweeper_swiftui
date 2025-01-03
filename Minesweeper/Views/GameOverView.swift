//
//  GameOverView.swift
//  Minesweeper
//
//  Created by Jared Cassoutt on 1/1/25.
//

import SwiftUI

struct GameOverView: View {
    @Binding var isVictory: Bool
    @Binding var completionTime: String
    var onNewGame: () -> Void
    var onContinue: () -> Void
    var onRestart: () -> Void
    var onShare: () -> Void
    
    var body: some View {
        VStack {
            titleText
            descriptionText
            if isVictory {
                shareResultButton
            } else {
                viewResultButton
            }
            newGameButton
            restartButton
        }
        .padding()
        .background(Color.background1)
        .cornerRadius(20)
    }
    
    private var titleText: some View {
        Text(isVictory ? "Congrats!" : "Game Over")
            .font(.largeTitle)
            .padding([.horizontal, .top])
    }
    
    private var descriptionText: some View {
        Text(isVictory ? "You completed the puzzle in just \(completionTime)" : "Unfortunately, you hit a bomb. Give it another try!")
            .padding(.horizontal)
    }
    
    private var shareResultButton: some View {
        Button(action: {
            onShare()
        }) {
            Text("Share Result")
                .font(.title2)
                .frame(width: 200, height: 50)
                .background(Color.purple.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding([.top, .horizontal])
    }
    
    private var viewResultButton: some View {
        Button(action: {
            onContinue()
        }) {
            Text("View Result")
                .font(.title2)
                .frame(width: 200, height: 50)
                .background(Color.purple.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding([.top, .horizontal])
    }
    
    private var newGameButton: some View {
        Button(action: {
            onNewGame()
        }) {
            Text("New Game")
                .font(.title2)
                .frame(width: 200, height: 50)
                .background(Color.green.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
    
    private var restartButton: some View {
        Button(action: {
            onRestart()
        }) {
            Text("Restart")
                .font(.title2)
                .frame(width: 200, height: 50)
                .background(Color.blue.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding([.horizontal, .bottom])
    }
}
