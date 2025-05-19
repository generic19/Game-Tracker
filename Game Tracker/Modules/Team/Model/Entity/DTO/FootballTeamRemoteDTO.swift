//
//  FootballTeamRemoteDTO.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//

import Foundation

struct FootballTeamRemoteDTO: RemoteDTO {
    let id: Int
    let name: String
    let image: String?
    let players: [PlayerDTO]?
    let coaches: [CoachDTO]?

    enum CodingKeys: String, CodingKey {
        case id = "team_key"
        case name = "team_name"
        case image = "team_logo"
        case players = "players"
        case coaches = "coaches"
    }

    struct PlayerDTO: Decodable {
        let name: String
        let image: String?
        let role: String?

        enum CodingKeys: String, CodingKey {
            case name  = "player_name"
            case image = "player_image"
            case role  = "player_type"
        }

        func toModel() -> Person {
            let imageURL: URL? = image?.hasSuffix("/") == false ? URL(string: image!) : nil
            return Person(name: name, image: imageURL, role: role)
        }
    }

    struct CoachDTO: Decodable {
        let name: String

        enum CodingKeys: String, CodingKey {
            case name = "coach_name"
        }

        func toModel() -> Person {
            return Person(name: name, image: nil, role: nil)
        }
    }

    func toModel() -> Team {
        let imageURL: URL? = image?.hasSuffix("/") == false ? URL(string: image!) : nil
        let playersModel = players?.map { $0.toModel() }
        let coachesModel = coaches?.map { $0.toModel() }
        
        return Team(
            id: id,
            sport: .football,
            name: name,
            image: imageURL,
            players: playersModel,
            coaches: coachesModel
        )
    }
}
