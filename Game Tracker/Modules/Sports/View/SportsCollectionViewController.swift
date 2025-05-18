//
//  SportsCollectionViewController.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 11/05/2025.
//

import UIKit

private let reuseIdentifier = "cell"

private let sports: [(Sport, String, String)] = [
    (.football, "soccerball", "Football"),
    (.basketball, "basketball", "Basketball"),
    (.cricket, "cricket.ball", "Cricket"),
    (.tennis, "tennisball", "Tennis"),
]

class SportsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var router: SportsRouter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SportCollectionViewCell
        
        let sport = sports[indexPath.row]
        cell.ivImage.image = UIImage(systemName: sport.1)
        cell.lblTitle.text = sport.2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let containerWidth = collectionView.frame.size.width
        let side = (containerWidth - 80) / 2
        
        return CGSize(width: side, height: side)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sport = sports[indexPath.row].0
        router.navigateToLeagues(with: navigationController!, sport: sport)
    }
}
