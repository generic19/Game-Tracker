//
//  PersonTableViewCell.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 20/05/2025.
//

import UIKit
import SDWebImage

class PersonTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var svInfo: UIStackView!
    @IBOutlet weak var ivPhoto: UIImageView!
    
    func configure(with person: Person) {
        lblName.text = person.name
        ivPhoto.sd_setImage(with: person.image, placeholderImage: UIImage(named: "placeholder-person"))
        
        if let role = person.role {
            lblRole.text = role
            lblRole.isHidden = false
            svInfo.addArrangedSubview(lblRole)
        } else {
            lblRole.isHidden = true
            svInfo.removeArrangedSubview(lblRole)
        }
    }
}
