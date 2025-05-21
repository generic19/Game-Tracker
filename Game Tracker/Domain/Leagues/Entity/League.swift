//
//  League.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//
import Foundation

struct League: Model, Equatable {
    let sport: Sport
    let id: Int
    let name: String
    let categoryName: String?
    let logo: URL?
    let categoryLogo: URL?
    var isFavorite: Bool
    
    static func == (lhs: League, rhs: League) -> Bool {
        return lhs.id == rhs.id
    }
}
