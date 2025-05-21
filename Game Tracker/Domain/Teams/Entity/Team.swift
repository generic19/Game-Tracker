//
//  Team.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import Foundation

struct Team: Model {
    let id: Int
    let sport: Sport
    let name: String
    let image: URL?
    let players: [Person]?
    let coaches: [Person]?
}
