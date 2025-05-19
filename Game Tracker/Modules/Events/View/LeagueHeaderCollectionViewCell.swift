//
//  LeagueHeaderCollectionViewCell.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//

import UIKit
import SDWebImage

class LeagueHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var ivCategory: UIImageView!
    @IBOutlet weak var ivCategoryHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with league: League) {
        lblName.text = league.name
        lblCategory.text = league.categoryName
        
        ivLogo.sd_setImage(with: league.logo)
        ivLogo.layer.cornerRadius = ivLogo.frame.width / 2
        
        if let categoryLogo = league.categoryLogo {
            ivCategoryHeightConstraint.constant = 32
            ivCategory.isHidden = false
            ivCategory.sd_setImage(with: categoryLogo)
        } else {
            ivCategoryHeightConstraint.constant = 0
            ivCategory.isHidden = true
        }
        
        layoutIfNeeded()
    }
}
