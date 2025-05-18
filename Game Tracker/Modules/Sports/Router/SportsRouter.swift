//
//  SportsRouter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 17/05/2025.
//
import UIKit

protocol SportsRouter {
    func prepareViewController() -> SportsCollectionViewController
    func navigateToLeagues(with: UINavigationController, sport: Sport)
}
