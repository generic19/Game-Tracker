//
//  DBSport.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 15/05/2025.
//

extension LeagueEntity {
    var sport: Sport {
        get { Sport(rawValue: sportRaw!)! }
        set { sportRaw = newValue.rawValue }
    }
}
