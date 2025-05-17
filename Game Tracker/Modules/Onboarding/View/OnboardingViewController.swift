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
            (UIImage(systemName: "photo")!, "Welcome", "Follow your favorite sport.", false),
            (UIImage(systemName: "photo")!, "Leagues", "Explore matches by league.", false),
            (UIImage(systemName: "photo")!, "Teams", "Track your favorite teams.", false),
            (UIImage(systemName: "photo")!, "Players", "Check on the players of your favorite team.", true),
        ]
        
        pages = items.map({ (image, title, details, lastPage) in
            let controller = storyboard!.instantiateViewController(identifier: "OnboardingItem") as! OnboardingItemViewController
            
            controller.delegate = self
            controller.pageImage = image
            controller.pageTitle = title
            controller.pageDetails = details
            
            controller.buttonText = if lastPage {
                "Let's Go!"
            } else {
                "Next"
            }
            
            return controller
        })
        
        setViewControllers([pages[0]], direction: .forward, animated: true)
        didMove(toParent: pages[0])
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let current = pages.firstIndex(of: viewController)!
        return if current < pages.count - 1 { pages[current + 1] } else { nil }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let current = pages.firstIndex(of: viewController)!
        return if current > 0 { pages[current - 1] } else { nil }
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
