//
//  GetFavoriteLeaguesUseCase.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//

class GetFavoriteLeaguesUseCase {
    let repository: LeaguesRepository
    
    init(repository: LeaguesRepository) {
        self.repository = repository
    }
    
    func execute(completionHandler: @escaping (Result<[League], Error>) -> Void) {
        repository.getFavoriteLeagues(completionHandler: completionHandler)
    }
}
