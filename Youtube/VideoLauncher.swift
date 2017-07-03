//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Thanh Tu Le Xuan on 7/3/17.
//  Copyright © 2017 Thanh Tu Le Xuan. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pauseAndPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePauseAndPlay), for: .touchUpInside)
        return button
    }()
    
    var isPlaying = true
    func handlePauseAndPlay() {
        if isPlaying {
            player?.pause()
            pauseAndPlayButton.setImage(#imageLiteral(resourceName: "play-button"), for: .normal)
        } else {
            player?.play()
            pauseAndPlayButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
        print(isPlaying)
    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pauseAndPlayButton)
        pauseAndPlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pauseAndPlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pauseAndPlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pauseAndPlayButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        
    }
    
    var player: AVPlayer?
    
    func setupPlayerView() {
        let u = "https://dvmaytinh.com/TranThienThuong/Nhac.mp4"
        if let url = URL(string: u) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //this is when the player ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pauseAndPlayButton.isHidden = false
//            isPlaying = true
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height, width: 10, height: 10)
            
            let h = keyWindow.frame.width / 16 * 9
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: h)
            let videoPlayer = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayer)
            
            
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { 
                view.frame = keyWindow.frame
            }, completion: { (bool) in
                //Hide status bar
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
    
    
    
}
