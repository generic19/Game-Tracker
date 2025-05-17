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
    private let storyboard: UIStoryboard
    
    init(window: UIWindow, container: Container) {
        self.window = window
        self.resolver = container
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
    }
    
    func start() {
        let controller = storyboard.instantiateViewController(withIdentifier: "Splash") as! SplashViewController
        let presenter = resolver.resolve(SplashPresenter.self)!
        
        controller.presenter = presenter
        controller.router = self
        presenter.view = controller
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    func showOnboarding() {
        let controller = storyboard.instantiateViewController(withIdentifier: "Onboarding") as! OnboardingViewController
        
        controller.router = self
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    func showMainTabs() {
        let sportsViewController = storyboard.instantiateViewController(withIdentifier: "Sports") as! SportsCollectionViewController
        
        let sportsNavController = UINavigationController(rootViewController: sportsViewController)
        
        sportsNavController.tabBarItem = UITabBarItem(
            title: "Sports",
            image: UIImage(systemName: "soccerball"),
            tag: 0
        )
        
        let leaguesViewController = storyboard.instantiateViewController(withIdentifier: "Leagues") as! LeaguesTableViewController
        
        let leaguesPresenter = resolver.resolve(LeaguesPresenter.self, argument: LeaguesPresenterArguments(mode: .favorites))!
        
        leaguesPresenter.view = leaguesViewController
        leaguesViewController.presenter = leaguesPresenter
        
        let leaguesNavController = UINavigationController(rootViewController: leaguesViewController)
        
        leaguesNavController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart.fill"),
            tag: 1
        )
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [sportsNavController, leaguesNavController]
        
        UIView.transition(with: window, duration: 0.2, options: .transitionFlipFromRight) {
            self.window.rootViewController = tabBarController
        }
    }
}
