//
//  TeamsRepository.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//

protocol TeamsRepository {
    func getTeams(league: League, completionHandler: @escaping (Result<[Team], Error>) -> Void)
}
