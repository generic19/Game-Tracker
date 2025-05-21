//
//  GetLeaguesUseCase.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//

class GetLeaguesUseCase {
    let repository: LeaguesRepository
    
    init(repository: LeaguesRepository) {
        self.repository = repository
    }
    
    func execute(sport: Sport, completionHandler: @escaping (LeaguesResult) -> Void) {
        repository.getLeagues(sport: sport, completionHandler: completionHandler)
    }
}
