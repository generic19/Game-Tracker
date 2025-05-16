//
//  LeaguesRepository.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 15/05/2025.
//

import Foundation

protocol LeaguesRepository {
    func getLeagues(sport: Sport, completionHandler: (Result<League, Error>) -> Void)
}
