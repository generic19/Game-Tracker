//
//  SetFavoriteLeagueUseCase.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//

class SetFavoriteLeagueUseCase {
    let repository: LeaguesRepository
    
    init(repository: LeaguesRepository) {
        self.repository = repository
    }
    
    func execute(league: League, isFavorite: Bool, completionHandler: @escaping (Result<League, Error>) -> Void) {
        repository.setFavorite(league: league, isFavorite, completionHandler: completionHandler)
    }
}
