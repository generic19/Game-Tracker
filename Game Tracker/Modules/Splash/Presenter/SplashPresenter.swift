//
//  SplashPresenter.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 17/05/2025.
//
import UIKit

protocol SplashView: AnyObject {
    func navigateToMain()
    func navigateToOnboarding()
}

class SplashPresenter {
    weak var view: (any SplashView)?
    
    func videoDone() {
        let showOnboarding = UserDefaults.standard.object(forKey: UserDefaultsKeys.ShouldShowOnboarding) as? Bool ?? true
        
        if showOnboarding {
            view?.navigateToOnboarding()
        } else {
            view?.navigateToMain()
        }
    }
}
