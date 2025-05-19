//
//  TeamCollectionViewCell.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//

import UIKit
import SDWebImage

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with team: Team) {
        lblName.text = team.name
        ivLogo.sd_setImage(with: team.image)
        ivLogo.layer.cornerRadius = ivLogo.frame.width / 2
    }
}
