//
//  ConcreteSportsRouter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 18/05/2025.
//
import UIKit
import Swinject

class ConcreteSportsRouter: SportsRouter {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func prepareViewController() -> SportsCollectionViewController {
        let storyboard = resolver.resolve(UIStoryboard.self, name: "Main")!
        let sportsViewController = storyboard.instantiateViewController(withIdentifier: "Sports") as! SportsCollectionViewController
        
        sportsViewController.router = resolver.resolve(SportsRouter.self)!
        
        return sportsViewController
    }
    
    func navigateToLeagues(with navigationController: UINavigationController, sport: Sport) {
        let router = resolver.resolve(LeaguesRouter.self)!
        let controller = router.prepareViewController(mode: .sport(sport))
        
        navigationController.pushViewController(controller, animated: true)
    }
}
