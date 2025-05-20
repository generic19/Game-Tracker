//
//  TeamsAssembly.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//

import Swinject

class TeamsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TeamsRemoteDataSource.self) { r in
            ConcreteTeamsRemoteDataSource(service: r.resolve(SportsAPIService.self)!)
        }
        
        container.register(TeamsRepository.self) { r in
            ConcreteTeamsRepository(remoteDataSource: r.resolve(TeamsRemoteDataSource.self)!)
        }
        
        container.register(FetchLeagueTeamsUseCase.self) { r in
            FetchLeagueTeamsUseCase(repository: r.resolve(TeamsRepository.self)!)
        }
        
        container.register(TeamRouter.self, factory: {r in ConcreteTeamRouter(resolver: r)})
    }
}
