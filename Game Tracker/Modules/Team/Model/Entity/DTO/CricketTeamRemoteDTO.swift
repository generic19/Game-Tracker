//
//  CricketTeamRemoteDTO.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//
import Foundation

struct CricketTeamRemoteDTO: RemoteDTO {
    let id: Int
    let name: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id = "team_key"
        case name = "team_name"
        case image = "team_logo"
    }

    func toModel() -> Team {
        let imageURL: URL? = image?.hasSuffix("/") == false ? URL(string: image!) : nil
        return Team(
            id: id,
            sport: .cricket,
            name: name,
            image: imageURL,
            players: nil,
            coaches: nil
        )
    }
}
