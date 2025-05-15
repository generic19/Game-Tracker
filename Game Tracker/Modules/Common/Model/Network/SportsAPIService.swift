//
//  SportsAPI.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 14/05/2025.
//
import Foundation

protocol SportsAPIService {
    func fetchLeagues<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        completionHandler: @escaping (Result<[T], Error>) -> Void
    )
    
    func fetchEvents<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        leagueId: Int,
        from startDate: Date,
        to endDate: Date,
        completionHandler: @escaping (Result<[T], Error>) -> Void
    )
    
    func fetchTeams<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        leagueId: Int,
        completionHandler: @escaping (Result<[T], Error>) -> Void
    )
    
    func fetchTeam<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        teamId: Int,
        completionHandler: @escaping (Result<[T], Error>) -> Void
    )
}
