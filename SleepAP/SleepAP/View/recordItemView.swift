//
//  recordItemView.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/20/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

let leftRightMargin : CGFloat = 50.0
let labelTopMargin : CGFloat = 30.0

class recordItemView: UIView {
    
    @IBOutlet var itemView: UIView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var percentNumber: UILabel!
    @IBOutlet var slideBar: customSlider!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "recordItemView", bundle: nil).instantiate(withOwner: self, options: nil)
        self.backgroundColor = .clear
        addSubview(itemView)
        itemView.frame = self.bounds
        
        // default global itemName label settings
        itemName.textColor = UIColor(red:0.25, green:0.30, blue:0.36, alpha:1.0)
        itemName.font = UIFont(name: "Chalkduster", size: 22)
        itemName.textAlignment = .center
        
        // default global percentNumber label settings
        percentNumber.textColor = UIColor(red:0.25, green:0.30, blue:0.36, alpha:1.0)
        percentNumber.font = UIFont(name: "Chalkduster", size: 28)
        percentNumber.textAlignment = .center
        
        // defautl global slide bar settings
        slideBar.value = 0.0
        slideBar.translatesAutoresizingMaskIntoConstraints = false
        slideBar.tintColor = UIColor(red:0.96, green:0.93, blue:0.55, alpha:1.0)
        slideBar.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        slideBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 60)
        slideBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftRightMargin)
        slideBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: leftRightMargin)
    }
    
    func customSliderWith(width: CGFloat, height: CGFloat, name: String, percent: String, imageName: String) {
        self.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        itemView.frame = self.bounds
        setItemNameWith(text: name)
        setPercentNumberWith(text: percent)
        setSlideBarWith(imageName: imageName)
    }
    
    func setItemNameWith(text: String) {
        itemName.text = text
        itemName.sizeToFit()
        let size = itemName.intrinsicContentSize
        itemName.frame = CGRect(x: leftRightMargin, y: labelTopMargin, width: size.width, height: size.height)
    }
    
    func setPercentNumberWith(text: String) {
        percentNumber.text = text
        percentNumber.sizeToFit()
        let size = percentNumber.intrinsicContentSize
        percentNumber.frame = CGRect(x: itemView.frame.size.width - leftRightMargin, y: labelTopMargin, width: size.width, height: size.height)
    }
    
    func setSlideBarWith(imageName: String) {
        slideBar.setThumbImage(UIImage(named: imageName), for: .normal)
    }
}
