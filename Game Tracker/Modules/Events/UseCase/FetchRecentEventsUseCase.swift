//
//  FetchRecentEventsUseCase.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//


class FetchRecentEventsUseCase {
    let repository: EventsRepository
    
    init(repository: EventsRepository) {
        self.repository = repository
    }
    
    func execute(league: League, completionHandler: @escaping (Result<[Event], Error>) -> Void) {
        repository.getRecentEvents(for: league, completionHandler: completionHandler)
    }
}
