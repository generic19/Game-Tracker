//
//  EventsRemoteDataSource.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//

protocol EventsRemoteDataSource {
    func getUpcomingEvents(for league: League) -> Result<[Event], Error>
    func getRecentEvents(for league: League) -> Result<[Event], Error>
}
