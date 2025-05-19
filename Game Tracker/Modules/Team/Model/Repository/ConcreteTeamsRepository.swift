//
//  ConcreteTeamsRepository.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//
import Foundation

private let queue = DispatchQueue.global(qos: .userInitiated)

class ConcreteTeamsRepository: TeamsRepository {
    private let remoteDataSource: TeamsRemoteDataSource
    
    init(remoteDataSource: TeamsRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getTeams(league: League, completionHandler: @escaping (Result<[Team], Error>) -> Void) {
        queue.async {
            let result = self.remoteDataSource.getTeams(league: league)
            completionHandler(result)
        }
    }
}
