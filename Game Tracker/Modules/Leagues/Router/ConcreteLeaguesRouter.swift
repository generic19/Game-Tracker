//
//  ConcreteLeaguesRouter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import Swinject

class ConcreteLeaguesRouter: LeaguesRouter {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func prepareViewController(mode: LeaguesMode) -> LeaguesTableViewController {
        let storyboard = resolver.resolve(UIStoryboard.self, name: "Main")!
        let controller = storyboard.instantiateViewController(withIdentifier: "Leagues") as! LeaguesTableViewController
        
        let presenter = resolver.resolve(LeaguesPresenter.self, argument: LeaguesPresenterArguments(mode: mode))!
        
        presenter.view = controller
        controller.presenter = presenter
        controller.router = resolver.resolve(LeaguesRouter.self)!
        
        return controller
    }
    
    func navigateToEvents(with navigationController: UINavigationController, league: League) {
        let router = resolver.resolve(EventsRouter.self)!
        let controller = router.prepareViewController(league: league)
        
        navigationController.pushViewController(controller, animated: true)
    }
}
