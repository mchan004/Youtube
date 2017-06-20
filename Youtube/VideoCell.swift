//
//  VideoCell.swift
//  Youtube
//
//  Created by Thanh Tu Le Xuan on 6/9/17.
//  Copyright © 2017 Thanh Tu Le Xuan. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    var video: Video? {
        didSet {
            titleLablel.text = video?.title
            
            setupThumbnailImage()
            
            if let profileImageName = video?.channel?.profileImageName {
                userProfileImageView.image = UIImage(named: profileImageName)
            }
            
            
        }
    }
    
    func setupThumbnailImage(){
        if let url = video?.thumbnaiImageName {
            print(url)
            let u = URL(string: url)
            URLSession.shared.dataTask(with: u!) { (data, res, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                self.thumbnailImageView.image = UIImage(data: data!)
            }.resume()
        }
        
        
        
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        //imageView.image = #imageLiteral(resourceName: "jangmi")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    
    let userProfileImageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        //img.image = #imageLiteral(resourceName: "ava")
        img.layer.cornerRadius = 22
        img.layer.masksToBounds = true
        return img
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    let titleLablel: UILabel = {
        let lbl = UILabel()
        lbl.text = "[Offical MV] Đưa nhau đi trốn - Đen ft. Linh Cáo (Prod. by Suicidal illness)"
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let subtitleTextView: UITextView = {
        let tv = UITextView()
        tv.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        tv.text = "TaylorSwiftVEVO asd aa bb.. 1,655,448,444 view 2 year ago"
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        return tv
    }()
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLablel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLablel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLablel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLablel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLablel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLablel, attribute: .bottom, multiplier: 1, constant: 4))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    
    
}


