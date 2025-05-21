//
//  ConcreteEventsRemoteDataSource.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import Foundation

class ConcreteEventsRemoteDataSource: EventsRemoteDataSource {
    private let service: SportsAPIService
    
    init(service: SportsAPIService) {
        self.service = service
    }
    
    func getUpcomingEvents(for league: League) -> Result<[Event], Error> {
        let rangeDays = switch league.sport {
            case .football: 14
            case .basketball: 14
            case .cricket: 365
            case .tennis: 365
        }
        
        let from = Date.now
        let to = from.addingTimeInterval(TimeInterval(rangeDays * 24 * 60 * 60))
        
        return getEvents(from: from, to: to, for: league)
    }
    
    func getRecentEvents(for league: League) -> Result<[Event], Error> {
        let rangeDays = switch league.sport {
            case .football: 14
            case .basketball: 14
            case .cricket: 365
            case .tennis: 365
        }
        
        let to = Date.now
        let from = to.addingTimeInterval(TimeInterval(-rangeDays * 24 * 60 * 60))
        
        return getEvents(from: from, to: to, for: league)
    }
    
    private func getEvents(from: Date, to: Date, for league: League) -> Result<[Event], Error> {
        let result = switch league.sport {
            case .football:
                service.fetchEvents(
                    as: FootballEventRemoteDTO.self,
                    sport: league.sport,
                    leagueId: league.id,
                    from: from,
                    to: to
                )
                
            case .basketball:
                service.fetchEvents(
                    as: BasketballEventRemoteDTO.self,
                    sport: league.sport,
                    leagueId: league.id,
                    from: from,
                    to: to
                )
                
            case .cricket:
                service.fetchEvents(
                    as: CricketEventRemoteDTO.self,
                    sport: league.sport,
                    leagueId: league.id,
                    from: from,
                    to: to
                )
                
            case .tennis:
                service.fetchEvents(
                    as: TennisEventRemoteDTO.self,
                    sport: league.sport,
                    leagueId: league.id,
                    from: from,
                    to: to
                )
        }
        
        switch result {
            case .success(let dtos):
                let events = dtos.map { $0.toModel() as! Event }
                return .success(events)
                
            case .failure(let error):
                return .failure(error)
        }
    }
}
