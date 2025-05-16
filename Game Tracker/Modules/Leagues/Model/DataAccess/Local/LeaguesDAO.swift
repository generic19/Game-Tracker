//
//  LeaguesDAO.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//

protocol LeaguesDAO {
    func getFavorites() -> Result<[LeagueEntity], Error>
    func setFavorite(league: League) -> Result<LeagueEntity, Error>
    func unsetFavorite(leagueById leagueId: Int64) -> Result<Void, Error>
}
