//
//  FetchUpcomingEventsUseCase.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//

class FetchUpcomingEventsUseCase {
    let repository: EventsRepository
    
    init(repository: EventsRepository) {
        self.repository = repository
    }
    
    func execute(league: League, completionHandler: @escaping (Result<[Event], Error>) -> Void) {
        repository.getUpcomingEvents(for: league, completionHandler: completionHandler)
    }
}
