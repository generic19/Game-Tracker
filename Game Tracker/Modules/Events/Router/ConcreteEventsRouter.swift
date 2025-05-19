//
//  ConcreteEventsRouter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//
import Swinject
import UIKit

class ConcreteEventsRouter: EventsRouter {
    let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func prepareViewController(league: League) -> EventsViewController {
        let storyboard = resolver.resolve(UIStoryboard.self, name: "Main")!
        let controller = storyboard.instantiateViewController(withIdentifier: "Events") as! EventsViewController
        let presenter = resolver.resolve(EventsPresenter.self)!
        
        presenter.league = league
        presenter.view = controller
        
        controller.presenter = presenter
        controller.router = self
        
        return controller
    }
    
    func navigateToTeam(_ team: Team) {
        
    }
}
