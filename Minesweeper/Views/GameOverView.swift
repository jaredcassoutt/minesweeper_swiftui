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
            Text(isVictory ? "Congrats!" : "Game Over")
                .font(.largeTitle)
                .padding([.horizontal, .top])
            
            Text(isVictory ? "You completed the puzzle in just \(completionTime)" : "Unfortunately, you hit a bomb. Give it another try!")
                .padding(.horizontal)
            
            if isVictory {
                Button(action: {
                    onNewGame()
                }) {
                    Text("New Game")
                        .font(.title2)
                        .frame(width: 200, height: 50)
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding([.top, .horizontal])
                
                Button(action: {
                    onRestart()
                }) {
                    Text("Restart")
                        .font(.title2)
                        .frame(width: 200, height: 50)
                        .background(Color.green.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                    onShare()
                }) {
                    Text("Share Results")
                        .font(.title2)
                        .frame(width: 200, height: 50)
                        .background(Color.purple.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding([.horizontal, .bottom])
            } else {
                Button(action: {
                    onNewGame()
                }) {
                    Text("New Game")
                        .font(.title2)
                        .frame(width: 200, height: 50)
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding([.top, .horizontal])
                
                Button(action: {
                    onRestart()
                }) {
                    Text("Restart")
                        .font(.title2)
                        .frame(width: 200, height: 50)
                        .background(Color.green.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            
        }
        .padding()
        .background(.background1)
        .cornerRadius(20)
    }
}
