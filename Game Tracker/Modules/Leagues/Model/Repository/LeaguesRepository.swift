//
//  LeaguesRepository.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 15/05/2025.
//

import Foundation

enum LeaguesResult {
    case success([League])
    case cached([League], any Error)
    case failure(any Error)
}

protocol LeaguesRepository {
    func getLeagues(sport: Sport, completionHandler: @escaping (LeaguesResult) -> Void)
    func getFavoriteLeagues(sport: Sport, completionHandler: @escaping (Result<[League], Error>) -> Void)
    func setFavorite(league: League, _ favorite: Bool, completionHandler: @escaping (Result<League, Error>) -> Void)
}
