//
//  League.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//
import Foundation

struct League: Model {
    let sport: Sport
    let id: Int
    let name: String
    let categoryName: String?
    let logo: URL?
    let categoryLogo: URL?
    var isFavorite: Bool
}
