//
//  ConcreteLeaguesRepository.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//
import Dispatch

private let queue = DispatchQueue.global(qos: .userInitiated)

class ConcreteLeaguesRepository: LeaguesRepository {
    private let localDataSource: LeaguesLocalDataSource
    private let remoteDataSource: LeaguesRemoteDataSource
    
    init(localDataSource: LeaguesLocalDataSource, remoteDataSource: LeaguesRemoteDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    func getLeagues(sport: Sport, completionHandler: @escaping (LeaguesResult) -> Void) {
        queue.async {
            let result = self.remoteDataSource.getLeagues(for: sport)
            var resultOut: LeaguesResult!
            
            switch result {
                case .success(let leagues):
                    resultOut = .success(leagues)
                    
                case .failure(let networkError):
                    let localResult = self.localDataSource.getFavoriteLeagues()
                    switch localResult {
                        case .success(let leagues):
                            resultOut = .cached(leagues, networkError)
                        case .failure(let error):
                            resultOut = .failure(error)
                    }
            }
            
            completionHandler(resultOut)
        }
    }
    
    func updateLeaguesFavoriteState(leagues: [League], completionHandler: @escaping ([League]) -> Void) {
        queue.async {
            var leagues = leagues
            
            switch self.localDataSource.getFavoriteLeagues() {
                case .success(let favorites):
                    let favoriteIds = Set(favorites.map { $0.id })
                    for i in 0..<leagues.count {
                        leagues[i].isFavorite = favoriteIds.contains(leagues[i].id)
                    }
                    
                default: break
            }
            
            completionHandler(leagues)
        }
    }
    
    func getFavoriteLeagues(completionHandler: @escaping (Result<[League], Error>) -> Void) {
        queue.async {
            completionHandler(self.localDataSource.getFavoriteLeagues())
        }
    }
    
    func setFavorite(league: League, _ favorite: Bool, completionHandler: @escaping (Result<League, Error>) -> Void) {
        queue.async {
            let resultOut: Result<League, Error>!
            
            if favorite {
                resultOut = self.localDataSource.setFavorite(league: league)
            } else {
                resultOut = self.localDataSource.unsetFavorite(league: league)
            }
            
            completionHandler(resultOut)
        }
    }
}
