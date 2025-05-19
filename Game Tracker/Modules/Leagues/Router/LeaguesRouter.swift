//
//  LeaguesRouter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import UIKit

protocol LeaguesRouter {
    func prepareViewController(mode: LeaguesMode) -> LeaguesTableViewController
    func navigateToEvents(with navigationController: UINavigationController, league: League)
}
