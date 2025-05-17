//
//  LeaguesView.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//

protocol LeaguesView: AnyObject {
    func showLeagues(_ leagues: [League], sport: Sport?)
    func showError(title: String, message: String)
    func replaceLeague(_ league: League, with newLeague: League)
}
