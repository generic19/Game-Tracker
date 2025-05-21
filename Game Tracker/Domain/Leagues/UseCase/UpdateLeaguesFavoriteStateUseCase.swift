//
//  UpdateLeaguesFavoriteStateUseCase.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 20/05/2025.
//

class UpdateLeaguesFavoriteStateUseCase {
    let repository: LeaguesRepository
    
    init(repository: LeaguesRepository) {
        self.repository = repository
    }
    
    func execute(leagues: [League], completionHandler: @escaping ([League]) -> Void) {
        repository.updateLeaguesFavoriteState(leagues: leagues, completionHandler: completionHandler)
    }
}
