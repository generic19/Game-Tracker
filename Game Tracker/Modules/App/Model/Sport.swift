//
//  Sport.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 12/05/2025.
//

import Foundation

enum Sport: String {
    case football
    case basketball
    case cricket
    case tennis
}

extension Sport {
    var localizedName: String {
        let key = switch self {
            case .football: "sport_football"
            case .basketball: "sport_basketball"
            case .cricket: "sport_cricket"
            case .tennis: "sport_tennis"
        }
        return NSLocalizedString(key, comment: "For title")
    }
}
