//
//  BasketballEventRemoteDTO.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//
import Foundation

private let dateTimeFormatter = DateFormatter.standardDateTime()

struct BasketballEventRemoteDTO: RemoteDTO {
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
        case homeImage = "event_home_team_logo"
        case awayId = "away_team_key"
        case awayName = "event_away_team"
        case awayImage = "event_away_team_logo"
        case result = "event_final_result"
    }

    func toModel() -> Event {
        let dateTime = dateTimeFormatter.date(from: "\(date) \(time)")
        let homeImageURL: URL? = homeImage?.hasSuffix("/") == false ? URL(string: homeImage!) : nil
        let awayImageURL: URL? = awayImage?.hasSuffix("/") == false ? URL(string: awayImage!) : nil

        return Event(
            id: id,
            datetime: dateTime,
            firstParticipant: .team(Team(
                id: homeId,
                sport: .basketball,
                name: homeName,
                image: homeImageURL,
                players: nil,
                coaches: nil
            )),
            secondParticipant: .team(Team(
                id: awayId,
                sport: .basketball,
                name: awayName,
                image: awayImageURL,
                players: nil,
                coaches: nil
            )),
            result: result
        )
    }
}
