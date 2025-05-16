//
//  AppContainer.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//
import Swinject

class AppContainer {
    static let shared = AppContainer()
    
    let container = Container()
    
    private init() {
        registerDependencies()
    }
    
    private func registerDependencies() {
        ServicesAssembly().assemble(container: container)
        LeaguesAssembly().assemble(container: container)
    }
}
