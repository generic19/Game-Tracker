//
//  LeagueRemoteDTOs.swift
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
}

struct BasketballLeagueRemoteDTO: RemoteDTO {
    let leagueKey: Int
    let leagueName: String
    let countryName: String
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryName = "country_name"
    }
}

struct CricketLeagueRemoteDTO: RemoteDTO {
    let leagueKey: Int
    let leagueName: String
    let leagueYear: String
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueYear = "league_year"
    }
}

struct TennisLeagueRemoteDTO: RemoteDTO {
    let leagueKey: Int
    let leagueName: String
    let countryName: String
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryName = "country_name"
    }
}

extension FootballLeagueRemoteDTO: ModelConvertible {
    func toModel() -> League {
        var logo: URL?
        if let urlString = leagueLogo, !urlString.hasSuffix("/") {
            logo = URL(string: urlString)
        }
        
        var categoryLogo: URL?
        if let urlString = leagueLogo, !urlString.hasSuffix("/") {
            categoryLogo = URL(string: urlString)
        }
        
        return League(
            sport: .football,
            id: leagueKey,
            name: leagueName,
            categoryName: countryName,
            logo: logo,
            categoryLogo: categoryLogo,
        )
    }
}

extension BasketballLeagueRemoteDTO: ModelConvertible {
    func toModel() -> League {
        return League(
            sport: .basketball,
            id: leagueKey,
            name: leagueName,
            categoryName: countryName,
            logo: nil,
            categoryLogo: nil
        )
    }
}

extension CricketLeagueRemoteDTO: ModelConvertible {
    func toModel() -> League {
        return League(
            sport: .cricket,
            id: leagueKey,
            name: leagueName,
            categoryName: leagueYear,
            logo: nil,
            categoryLogo: nil
        )
    }
}

extension TennisLeagueRemoteDTO: ModelConvertible {
    func toModel() -> League {
        return League(
            sport: .tennis,
            id: leagueKey,
            name: leagueName,
            categoryName: countryName,
            logo: nil,
            categoryLogo: nil
        )
    }
}
