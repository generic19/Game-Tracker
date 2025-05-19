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
            switch result {
                case .success(let events):
                    let sorted = events
                        .filter { $0.result == nil }
                        .sorted {
                            if let date1 = $0.datetime, let date2 = $1.datetime {
                                date1 < date2
                            } else {
                                $0.id < $1.id
                            }
                        }
                    completionHandler(.success(sorted))
                    
                default:
                    completionHandler(result)
            }
        }
    }
    
    func getRecentEvents(for league: League, completionHandler: @escaping (Result<[Event], Error>) -> Void) {
        queue.async {
            let result = self.remoteDataSource.getRecentEvents(for: league)
            switch result {
                case .success(let events):
                    let sorted = events
                        .filter { $0.result != nil }
                        .sorted {
                            if let date1 = $0.datetime, let date2 = $1.datetime {
                                date1 > date2
                            } else {
                                $0.id < $1.id
                            }
                        }
                    completionHandler(.success(sorted))
                    
                default:
                    completionHandler(result)
            }
        }
    }
}
