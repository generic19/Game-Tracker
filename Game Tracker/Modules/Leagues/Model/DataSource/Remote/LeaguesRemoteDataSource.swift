//
//  LeaguesRemoteDataSource.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//

protocol LeaguesRemoteDataSource {
    func getLeagues(for sport: Sport) -> Result<[League], Error>
}
