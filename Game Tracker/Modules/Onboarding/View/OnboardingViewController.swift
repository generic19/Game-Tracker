//
//  OnboardingViewController.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 17/05/2025.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    var router: (any OnboardingRouter)!
    var pages: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [
            (
                UIImage(named: "onboarding-1")!,
                "Your all-in-one sports companion",
                "Follow football, basketball, cricket and tennis leagues from kickoff to final whistle.",
                false
            ),
            (
                UIImage(named: "onboarding-2")!,
                "Single tap to get started",
                "Choose from Football, Basketball, Cricket or Tennis—and jump straight into the action for whichever you love.",
                false
            ),
            (
                UIImage(named: "onboarding-3")!,
                "Everything in one place",
                "Browse every league...\n\n" +
                "See upcoming fixtures and recent results at a glance...\n\n" +
                "Dive into team details with coaches and player rosters.",
                false
            ),
            (
                UIImage(named: "onboarding-4")!,
                "Never miss a beat",
                "Tap the ❤️ to save any league for quick access—even when you’re offline.*\n\n\n" +
                "*(Match details require an internet connection)",
                true
            ),
        ]
        
        pages = items.map({ (image, title, details, lastPage) in
            let controller = storyboard!.instantiateViewController(identifier: "OnboardingItem") as! OnboardingItemViewController
            
            controller.delegate = self
            controller.pageImage = image
            controller.pageTitle = title
            controller.pageDetails = details
            controller.buttonText = if lastPage { "Let's Go!" } else { "Next" }
            
            return controller
        })
        
        dataSource = self
        
        setViewControllers([pages[0]], direction: .forward, animated: false)
        didMove(toParent: pages[0])
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
}

extension OnboardingViewController: OnboardingItemViewController.Delegate {
    func pageItemMainAction(item: OnboardingItemViewController) {
        let index = pages.firstIndex(of: item)!
        
        if index < pages.count - 1 {
            setViewControllers([pages[index + 1]], direction: .forward, animated: true)
        } else {
            router.showMainTabs()
        }
    }
}
