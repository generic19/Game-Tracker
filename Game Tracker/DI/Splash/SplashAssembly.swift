//
//  SplashAssembly.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 17/05/2025.
//
import Swinject

class SplashAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SplashPresenter.self) { _ in SplashPresenter() }
    }
}
