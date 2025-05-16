//
//  LeaguesLocalDataSource.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//

protocol LeaguesLocalDataSource {
    func getFavoriteLeagues() -> Result<[League], Error>
    func setFavorite(league: League) -> Result<League, Error>
    func unsetFavorite(league: League) -> Result<League, Error>
}
