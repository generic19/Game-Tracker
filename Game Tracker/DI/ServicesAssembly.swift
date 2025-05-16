//
//  ServicesAssembly.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//
import Swinject

class ServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SportsAPIService.self) { _ in AlamofireSportsAPIService() }
    }
}
