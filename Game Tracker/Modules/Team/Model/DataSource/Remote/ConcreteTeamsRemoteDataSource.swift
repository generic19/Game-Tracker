//
//  ConcreteTeamsRemoteDataSource.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//
import Foundation

class ConcreteTeamsRemoteDataSource: TeamsRemoteDataSource {
    private let service: SportsAPIService
    
    init(service: SportsAPIService) {
        self.service = service
    }
    
    func getTeams(league: League) -> Result<[Team], Error> {
        let result: Result<[any ModelConvertible], Error> = switch league.sport {
            case .football:
                service.fetchTeams(
                    as: FootballTeamRemoteDTO.self,
                    sport: league.sport,
                    leagueId: league.id
                )
            case .basketball:
                service.fetchTeams(
                    as: BasketballTeamRemoteDTO.self,
                    sport: league.sport,
                    leagueId: league.id
                )
            case .cricket:
                service.fetchTeams(
                    as: CricketTeamRemoteDTO.self,
                    sport: league.sport,
                    leagueId: league.id
                )
            case .tennis:
                .failure(NSError(
                    domain: "ConcreteTeamsRemoteDataSource",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Fetching teams for tennis is not supported by the API."
                    ]
                ))
        }
        
        switch result {
            case .success(let dtos):
                let teams = dtos.map { $0.toModel() as! Team }
                return .success(teams)
            case .failure(let error):
                return .failure(error)
        }
    }
}
