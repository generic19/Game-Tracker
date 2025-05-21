//
//  SportsPresenter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import Foundation

protocol SportsView: AnyObject {
    func navigateToLeagues(sport: Sport)
}

class SportsPresenter {
    weak var view: (any SportsView)?
    
    func sportClicked(_ sport: Sport) {
        view?.navigateToLeagues(sport: sport)
    }
}
