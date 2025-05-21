//
//  EventCollectionViewCell.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//

import UIKit
import SDWebImage

private let dateFormatter = DateFormatter.displayDate()
private let timeFormatter = DateFormatter.displayTime()

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivHome: UIImageView!
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var ivAway: UIImageView!
    @IBOutlet weak var lblAway: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with event: Event) {
        lblHome.text = event.firstParticipant.name
        lblAway.text = event.secondParticipant.name
        
        let placeholder = switch event.firstParticipant {
            case .team: UIImage(named: "placeholder-team")
            case .player: UIImage(named: "placeholder-person")
        }
        
        ivHome.sd_setImage(with: event.firstParticipant.image, placeholderImage: placeholder)
        ivAway.sd_setImage(with: event.secondParticipant.image, placeholderImage: placeholder)
        
        ivHome.layer.cornerRadius = ivHome.frame.width / 2
        ivAway.layer.cornerRadius = ivAway.frame.width / 2
        
        if event.result != nil {
            lblTitle.text = event.result!
            lblSubtitle.text = if let datetime = event.datetime {
                dateFormatter.string(from: datetime)
            } else {
                "Finished"
            }
        } else if event.datetime != nil {
            lblTitle.text = timeFormatter.string(from: event.datetime!)
            lblSubtitle.text = dateFormatter.string(from: event.datetime!)
        } else {
            lblTitle.text = ""
            lblSubtitle.text = ""
        }
    }
}
