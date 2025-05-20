//
//  ConcreteTeamRouter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 20/05/2025.
//
import UIKit
import Swinject

class ConcreteTeamRouter: TeamRouter {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func prepareViewController(team: Team) -> TeamViewController {
        let storyboard = resolver.resolve(UIStoryboard.self, name: "Main")!
        let controller = storyboard.instantiateViewController(withIdentifier: "Team") as! TeamViewController
        controller.team = team
        return controller
    }
}
