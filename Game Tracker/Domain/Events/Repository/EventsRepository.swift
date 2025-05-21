//
//  EventsRepository.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//

protocol EventsRepository {
    func getUpcomingEvents(for league: League, completionHandler: @escaping (Result<[Event], Error>) -> Void)
    
    func getRecentEvents(for league: League, completionHandler: @escaping (Result<[Event], Error>) -> Void)
}
