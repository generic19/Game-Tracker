//
//  ConcreteLeaguesRemoteDataSource.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//
import Foundation

class ConcreteLeaguesRemoteDataSource: LeaguesRemoteDataSource {
    let service: SportsAPIService
    
    init(service: SportsAPIService) {
        self.service = service
    }
    
    func getLeagues(for sport: Sport) -> Result<[League], Error> {
        let result = switch sport {
            case .football: service.fetchLeagues(as: FootballLeagueRemoteDTO.self, sport: sport)
            case .basketball: service.fetchLeagues(as: BasketballLeagueRemoteDTO.self, sport: sport)
            case .cricket: service.fetchLeagues(as: CricketLeagueRemoteDTO.self, sport: sport)
            case .tennis: service.fetchLeagues(as: TennisLeagueRemoteDTO.self, sport: sport)
        }
        
        switch result {
            case .success(let dtos):
                let leagues = dtos.map { $0.toModel() as! League }
                return .success(leagues)
                
            case .failure(let error):
                return .failure(error)
        }
    }
}
