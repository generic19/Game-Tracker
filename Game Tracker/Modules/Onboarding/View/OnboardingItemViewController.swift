//
//  OnboardingItemViewController.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 17/05/2025.
//

import UIKit

class OnboardingItemViewController: UIViewController {
    
    protocol Delegate: AnyObject {
        func pageItemMainAction(item: OnboardingItemViewController)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btnMain: UIButton!
    
    weak var delegate: Delegate?
    
    var pageImage: UIImage?
    var pageTitle: String?
    var pageDetails: String?
    var buttonText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = pageImage
        lblTitle.text = pageTitle
        lblDetails.text = pageDetails
        btnMain.titleLabel?.text = buttonText
    }

    @IBAction func mainAction(_ sender: UIButton) {
        delegate?.pageItemMainAction(item: self)
    }
}
