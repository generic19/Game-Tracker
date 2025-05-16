//
//  CoreDataLeaguesLocalDataSource.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//

import CoreData

class ConcreteLeaguesLocalDataSource: LeaguesLocalDataSource {
    let dao: LeaguesDAO
    
    init(dao: LeaguesDAO) {
        self.dao = dao
    }
    
    func getFavoriteLeagues() -> Result<[League], Error> {
        let result = dao.getFavorites()
        
        switch result {
            case .success(let entities):
                let leagues = entities.map { $0.toDomain() }
                return .success(leagues)
                
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func setFavorite(league: League) -> Result<League, Error> {
        let result = dao.setFavorite(league: league)
        
        switch result {
            case .success:
                var newLeague = league
                newLeague.isFavorite = true
                return .success(league)
                
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func unsetFavorite(league: League) -> Result<League, Error> {
        let result = dao.unsetFavorite(leagueById: Int64(league.id))
        
        switch result {
            case .success:
                var newLeague = league
                newLeague.isFavorite = false
                return .success(league)
                
            case .failure(let error):
                return .failure(error)
        }
    }
}
