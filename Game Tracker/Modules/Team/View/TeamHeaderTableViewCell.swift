//
//  TeamHeaderTableViewCell.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 20/05/2025.
//

import UIKit
import SDWebImage

class TeamHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var lblName: UILabel!
 
    func configure(with team: Team) {
        ivLogo.sd_setImage(with: team.image)
        lblName.text = team.name
    }
}
