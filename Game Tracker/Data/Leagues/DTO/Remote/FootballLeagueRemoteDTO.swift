//
//  FootballLeagueRemoteDTO.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//
import Foundation

struct FootballLeagueRemoteDTO: RemoteDTO {
    let leagueKey: Int
    let leagueName: String
    let countryName: String
    let leagueLogo: String?
    let countryLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
    
    func toModel() -> League {
        var logo: URL?
        if let urlString = leagueLogo, !urlString.hasSuffix("/") {
            logo = URL(string: urlString)
        }
        
        var categoryLogo: URL?
        if let urlString = countryLogo, !urlString.hasSuffix("/") {
            categoryLogo = URL(string: urlString)
        }
        
        return League(
            sport: .football,
            id: leagueKey,
            name: leagueName,
            categoryName: countryName,
            logo: logo,
            categoryLogo: categoryLogo,
            isFavorite: false,
        )
    }
}
