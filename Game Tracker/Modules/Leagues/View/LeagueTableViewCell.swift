//
//  LeagueTableViewCell.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 20/05/2025.
//

import UIKit
import SDWebImage

class LeagueTableViewCell: UITableViewCell {
    @IBOutlet weak var lblLeague: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var ivLeague: UIImageView!
    @IBOutlet weak var ivCategory: UIImageView!
    @IBOutlet weak var svLeague: UIStackView!
    @IBOutlet weak var svInfo: UIStackView!
    @IBOutlet weak var svCategory: UIStackView!
    
    func configure(with league: League) {
        lblLeague.text = league.name
        ivLeague.sd_setImage(with: league.logo, placeholderImage: UIImage(named: "placeholder-league"))
        
        if let categoryName = league.categoryName {
            lblCategory.text = categoryName
            svCategory.isHidden = false
            svInfo.addArrangedSubview(svCategory)
            
            if let categoryLogo = league.categoryLogo {
                ivCategory.sd_setImage(with: categoryLogo)
                ivCategory.isHidden = false
                svCategory.insertArrangedSubview(ivCategory, at: 0)
            } else {
                ivCategory.isHidden = true
                svCategory.removeArrangedSubview(ivCategory)
            }
        } else {
            svCategory.isHidden = true
            svInfo.removeArrangedSubview(svCategory)
        }
        
        layoutIfNeeded()
    }
}
