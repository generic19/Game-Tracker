//
//  FetchLeagueTeamsUseCase.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//

class FetchLeagueTeamsUseCase {
    private let repository: TeamsRepository
    
    init(repository: TeamsRepository) {
        self.repository = repository
    }
    
    func execute(league: League, completionHandler: @escaping (Result<[Team], Error>) -> Void) {
        repository.getTeams(league: league, completionHandler: completionHandler)
    }
}
