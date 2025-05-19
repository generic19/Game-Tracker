//
//  Event.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import Foundation

enum Participant {
    case team(Team)
    case player(Person)
    
    var name: String {
        switch self {
            case .team(let team): team.name
            case .player(let player): player.name
        }
    }
    
    var image: URL? {
        switch self {
            case .team(let team): team.image
            case .player(let player): player.image
        }
    }
}

struct Event: Model {
    let id: Int
    let datetime: Date?
    let firstParticipant: Participant
    let secondParticipant: Participant
    let result: String?
}
