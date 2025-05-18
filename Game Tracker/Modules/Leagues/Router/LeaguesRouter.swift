//
//  LeaguesRouter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//

protocol LeaguesRouter {
    func prepareViewController(mode: LeaguesMode) -> LeaguesTableViewController
    func navigateToLeagueDetails(_ league: League)
}
