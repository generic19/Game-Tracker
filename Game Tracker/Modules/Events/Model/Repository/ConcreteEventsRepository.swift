//
//  ConcreteEventsRepository.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//
import Foundation

private let queue = DispatchQueue.global(qos: .userInitiated)

class ConcreteEventsRepository: EventsRepository {
    private let remoteDataSource: EventsRemoteDataSource
    
    init(remoteDataSource: EventsRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getUpcomingEvents(for league: League, completionHandler: @escaping (Result<[Event], Error>) -> Void) {
        queue.async {
            let result = self.remoteDataSource.getUpcomingEvents(for: league)
            completionHandler(result)
        }
    }
    
    func getRecentEvents(for league: League, completionHandler: @escaping (Result<[Event], Error>) -> Void) {
        queue.async {
            let result = self.remoteDataSource.getRecentEvents(for: league)
            completionHandler(result)
        }
    }
}
