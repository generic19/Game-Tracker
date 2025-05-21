//
//  LeagueEntity+Mapper.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//

extension LeagueEntity {
    func toDomain() -> League {
        return League(
            sport: sport,
            id: Int(id),
            name: name!,
            categoryName: categoryName,
            logo: logo,
            categoryLogo: categoryLogo,
            isFavorite: true,
        )
    }
}
