//
//  GameCenterHelper.swift
//  Minesweeper
//
//  Created by Jared Cassoutt on 1/1/25.
//

import GameKit

class GameCenterHelper: NSObject, ObservableObject {
    static let shared = GameCenterHelper()

    @Published var showAuthenticationView = false
    var authenticationViewController: UIViewController?

    override init() {
        super.init()
        authenticateUser()
    }

    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { [weak self] viewController, error in
            if let vc = viewController {
                // Present the authentication view controller
                self?.authenticationViewController = vc
                self?.showAuthenticationView = true
            } else if GKLocalPlayer.local.isAuthenticated {
                // Player is authenticated
                self?.showAuthenticationView = false
            } else {
                // Handle authentication failure
                self?.showAuthenticationView = false
                print("Error authenticating with Game Center: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    func reportScore(_ score: Int, forLeaderboardID leaderboardID: String) {
        let scoreReporter = GKScore(leaderboardIdentifier: leaderboardID)
        scoreReporter.value = Int64(score)
        GKScore.report([scoreReporter]) { error in
            if let error = error {
                print("Error reporting score: \(error.localizedDescription)")
            }
        }
    }
}
