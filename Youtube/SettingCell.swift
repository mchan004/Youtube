//
//  SettingCell.swift
//  Youtube
//
//  Created by Thanh Tu Le Xuan on 6/22/17.
//  Copyright © 2017 Thanh Tu Le Xuan. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        
        
        return label
    }()
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
        }
    }
    
    let iconImageView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "home").withRenderingMode(.alwaysTemplate)
        img.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        return img
    }()
    
    
    
    override var isSelected: Bool{
        didSet {
            iconImageView.tintColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            nameLabel.textColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            backgroundColor = isSelected ? #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }

    
    override func setupViews() {
        super.setupViews()
        
        addSubview(iconImageView)
        addSubview(nameLabel)
        
        
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
