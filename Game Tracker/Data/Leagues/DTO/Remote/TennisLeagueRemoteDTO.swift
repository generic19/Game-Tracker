//
//
//  TennisLeagueRemoteDTO.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//
import Foundation

struct TennisLeagueRemoteDTO: RemoteDTO {
    let leagueKey: Int
    let leagueName: String
    let countryName: String
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryName = "country_name"
    }
    
    func toModel() -> League {
        return League(
            sport: .tennis,
            id: leagueKey,
            name: leagueName,
            categoryName: countryName,
            logo: nil,
            categoryLogo: nil,
            isFavorite: false,
        )
    }
}
