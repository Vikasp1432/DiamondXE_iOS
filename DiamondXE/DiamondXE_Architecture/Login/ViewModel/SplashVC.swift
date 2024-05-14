//
//  SplashVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 10/05/24.
//

import UIKit
import AVKit
import AVFoundation

class SplashVC: BaseViewController {
    @IBOutlet var bgView : UIView!
    private var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = .red
        self.playVideo()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.3) {
            self.moveToRootVC()
        }
    }
    

    private func playVideo() {

        guard let videoURL = Bundle.main.url(forResource: "splashVD", withExtension: "mp4") else {
             fatalError("Video not found")
           }

           player = AVPlayer(url: videoURL)
        

           let playerLayer = AVPlayerLayer(player: player!)
           playerLayer.frame = view.bounds
           playerLayer.videoGravity = .resizeAspectFill
           
           // Add the player layer to the view
           view.layer.addSublayer(playerLayer)

           // Play the video
           player?.play()

           // Schedule to stop the video after 5 seconds
           DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
             self.player?.pause()
           }
         
        
        
       }
    
    func moveToRootVC(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            window.rootViewController = vc

            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3

            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
            { completed in
                // maybe do something on completion here
            })
        }
    }
    
}
