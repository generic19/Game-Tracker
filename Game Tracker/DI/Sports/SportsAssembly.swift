//
//  SportsAssembly.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import Swinject

class SportsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SportsPresenter.self) { _ in SportsPresenter() }
        container.register(SportsRouter.self) { r in ConcreteSportsRouter(resolver: r) }
    }
}

