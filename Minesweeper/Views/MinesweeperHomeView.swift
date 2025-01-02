//
//  MinesweeperHomeView.swift
//  Minesweeper
//
//  Created by Jared Cassoutt on 1/1/25.
//

import SwiftUI

struct MinesweeperHomeView: View {
    @StateObject var gameCenterHelper = GameCenterHelper.shared
    @State private var leaderboardID = ""
    @State private var showLeaderboard = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background1.ignoresSafeArea()
                
                VStack {
                    // Top-right leaderboard button
                    HStack {
                        Spacer()
                        Button {
                            showLeaderboard = true
                        } label: {
                            Image(systemName: "trophy")
                                .foregroundColor(.text1)
                                .padding()
                                .background(Color.background2)
                                .clipShape(Circle())
                        }
                        .padding()
                    }
                    
                    ZStack {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(15)
                    .rotationEffect(.degrees(-15))
                    .padding(.top, 40)
                    .shadow(color: .shadow, radius: 8, x: 2, y: 3)
                    
                    Text("Minesweeper.")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .padding()
                    
                    // Difficulty options
                    ForEach(MinesweeperDifficulty.allCases, id: \.self) { difficulty in
                        NavigationLink {
                            MinesweeperGameView(difficulty: difficulty)
                        } label: {
                            Text(difficulty.rawValue)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .frame(width: 200, height: 50)
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.bottom, 10)
                        }
                    }
                    
                    Spacer()
                }
            }
            .sheet(isPresented: $showLeaderboard) {
                GameCenterView(leaderboardID: leaderboardID) {
                    showLeaderboard = false
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
