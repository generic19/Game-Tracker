//
//
//  CricketLeagueRemoteDTO.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//
import Foundation

struct CricketLeagueRemoteDTO: RemoteDTO {
    let leagueKey: Int
    let leagueName: String
    let leagueYear: String
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueYear = "league_year"
    }
    
    func toModel() -> League {
        return League(
            sport: .cricket,
            id: leagueKey,
            name: leagueName,
            categoryName: leagueYear,
            logo: nil,
            categoryLogo: nil,
            isFavorite: false
        )
    }
}
