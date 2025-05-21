//
//  TeamsRemoteDataSource.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//

protocol TeamsRemoteDataSource {
    func getTeams(league: League) -> Result<[Team], Error>
}
