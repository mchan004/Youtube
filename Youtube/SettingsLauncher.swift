//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Thanh Tu Le Xuan on 6/21/17.
//  Copyright © 2017 Thanh Tu Le Xuan. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cv
    }()
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            
            
            blackView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 200)
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0.5
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height-200, width: window.frame.width, height: 200)
                
            }, completion: nil)
        }
    }
    
    func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 200)
            }
        }
    }
    
    override init() {
        super.init()
    }
}
