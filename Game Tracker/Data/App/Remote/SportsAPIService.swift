//
//  SportsAPI.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 14/05/2025.
//
import Foundation

typealias RemoteDTO = Decodable & Sendable & ModelConvertible

protocol SportsAPIService {
    func fetchLeagues<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
    ) -> Result<[any ModelConvertible], Error>
    
    func fetchEvents<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        leagueId: Int,
        from startDate: Date,
        to endDate: Date,
    ) -> Result<[any ModelConvertible], Error>
    
    func fetchTeams<T: RemoteDTO>(
        as type: T.Type,
        sport: Sport,
        leagueId: Int,
    ) -> Result<[any ModelConvertible], Error>
}
