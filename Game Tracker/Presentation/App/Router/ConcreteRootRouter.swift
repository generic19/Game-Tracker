//
//  RootRouter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 17/05/2025.
//
import UIKit
import Swinject

class ConcreteRootRouter: RootRouter, SplashRouter, OnboardingRouter {
    private let window: UIWindow
    private let resolver: any Resolver
    
    init(window: UIWindow, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
    }
    
    func start() {
        let storyboard = resolver.resolve(UIStoryboard.self, name: "Main")!
        
        let controller = storyboard.instantiateViewController(withIdentifier: "Splash") as! SplashViewController
        let presenter = resolver.resolve(SplashPresenter.self)!
        
        controller.presenter = presenter
        controller.router = self
        presenter.view = controller
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    func showOnboarding() {
        let storyboard = resolver.resolve(UIStoryboard.self, name: "Main")!
        
        let controller = storyboard.instantiateViewController(withIdentifier: "Onboarding") as! OnboardingViewController
        
        controller.router = self
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    func showMainTabs() {
        let storyboard = resolver.resolve(UIStoryboard.self, name: "Main")!
        
        let sportsRouter = resolver.resolve(SportsRouter.self)!
        let sportsViewController = sportsRouter.prepareViewController()
        let sportsNavController = UINavigationController(rootViewController: sportsViewController)
        
        sportsNavController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("sports", comment: "Sports tab"),
            image: UIImage(systemName: "soccerball"),
            tag: 0
        )
        
        let leaguesRouter = resolver.resolve(LeaguesRouter.self)!
        let leaguesViewController = leaguesRouter.prepareViewController(mode: .favorites)
        let leaguesNavController = UINavigationController(rootViewController: leaguesViewController)
        
        leaguesNavController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("favorites", comment: "Favorites tab"),
            image: UIImage(systemName: "heart.fill"),
            tag: 1
        )
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [sportsNavController, leaguesNavController]
        
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve) {
            self.window.rootViewController = tabBarController
        }
    }
}
