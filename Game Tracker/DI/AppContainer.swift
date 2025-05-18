//
//  AppContainer.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 16/05/2025.
//
import Swinject
import UIKit

class AppContainer {
    static let shared = AppContainer()
    
    let container = Container()
    
    private init() {
        registerDependencies()
    }
    
    private func registerDependencies() {
        container.register(UIStoryboard.self, name: "Main") { _ in UIStoryboard(name: "Main", bundle: nil) }
        
        let modulesAssemblies: [Assembly] = [
            ServicesAssembly(),
            SplashAssembly(),
            SportsAssembly(),
            LeaguesAssembly(),
        ]
        
        modulesAssemblies.forEach { $0.assemble(container: container) }
    }
}
