//
//  EventsRouter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//

protocol EventsRouter {
    func prepareViewController(league: League) -> EventsViewController
    func navigateToTeam(_ team: Team)
}
