//
//  SplashViewController.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 17/05/2025.
//

import UIKit
import AVFoundation

class SplashViewController: UIViewController, SplashView {
    var router: SplashRouter!
    var presenter: SplashPresenter!
    
    private var queuePlayer: AVQueuePlayer!
    private var playerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "splash-video", ofType: "mp4")!
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        
        let queuePlayer = AVQueuePlayer(items: [playerItem])
        
        queuePlayer.isMuted = true
        queuePlayer.actionAtItemEnd = .none
        
        playerLayer = AVPlayerLayer(player: queuePlayer)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = view.bounds
        view.layer.insertSublayer(playerLayer, at: 0)
        
        queuePlayer.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.presenter.videoDone()
        }
    }
    
    func navigateToOnboarding() {
        router.showOnboarding()
    }
    
    func navigateToMain() {
        router.showMainTabs()
    }
}
