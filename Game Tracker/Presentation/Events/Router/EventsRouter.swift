//
//  EventsRouter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import UIKit

protocol EventsRouter {
    func prepareViewController(league: League) -> EventsViewController
    func navigateToTeam(with navigationController: UINavigationController, team: Team)
}
