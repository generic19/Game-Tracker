//
//  SportsCollectionViewController.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 11/05/2025.
//

import UIKit

private let reuseIdentifier = "cell"

private let sports: [(Sport, String)] = [
    (.football, "football"),
    (.basketball, "basketball"),
    (.cricket, "cricket"),
    (.tennis, "tennis"),
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
        cell.ivImage.image = UIImage(named: sport.1)
        cell.lblTitle.text = sport.0.localizedName
        
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let containerWidth = collectionView.frame.size.width
        
        let width = (containerWidth - 48) / 2
        let height = if let superviewHeight = collectionView.superview?.frame.height {
            if superviewHeight > containerWidth {
                (superviewHeight - 280) / 2
            } else {
                width * 0.7
            }
        } else {
            width * 3 / 2 + 36
        }
        
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sport = sports[indexPath.row].0
        router.navigateToLeagues(with: navigationController!, sport: sport)
    }
}
