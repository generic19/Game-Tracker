//
//  FootballEventRemoteDTO.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import Foundation

private let dateTimeFormatter = DateFormatter.standardDateTime()

struct FootballEventRemoteDTO: RemoteDTO {
    let id: Int
    let date: String
    let time: String
    let homeId: Int
    let homeName: String
    let homeImage: String?
    let awayId: Int
    let awayName: String
    let awayImage: String?
    let result: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "event_key"
        case date = "event_date"
        case time = "event_time"
        case homeId = "home_team_key"
        case homeName = "event_home_team"
        case homeImage = "home_team_logo"
        case awayId = "away_team_key"
        case awayName = "event_away_team"
        case awayImage = "away_team_logo"
        case result = "event_final_result"
    }
    
    func toModel() -> Event {
        let dateTime = dateTimeFormatter.date(from: "\(date) \(time)")
        
        let homeImageURL: URL? = if homeImage?.hasSuffix("/") == false {
            URL(string: homeImage!)
        } else {
            nil
        }
        
        let awayImageURL: URL? = if awayImage?.hasSuffix("/") == false {
            URL(string: awayImage!)
        } else {
            nil
        }
        
        return Event(
            id: id,
            datetime: dateTime,
            firstParticipant: .team(
                Team(
                    id: homeId,
                    sport: .football,
                    name: homeName,
                    image: homeImageURL,
                    players: nil,
                    coaches: nil,
                )
            ),
            secondParticipant: .team(
                Team(
                    id: awayId,
                    sport: .football,
                    name: awayName,
                    image: awayImageURL,
                    players: nil,
                    coaches: nil,
                )
            ),
            result: (result != "-" ? result : nil),
        )
    }
}
