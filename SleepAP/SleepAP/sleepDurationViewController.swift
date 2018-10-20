//
//  sleepDurationViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/19/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class sleepDurationViewController: sleepRelatedViewController {

    @IBOutlet weak var sleepDurationLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesButton: buttonView!
    @IBOutlet weak var noButton: buttonView!
    @IBOutlet weak var questionLabelTopMargin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sleepDurationLabel settings
        sleepDurationLabel.textColor = UIColor(red:255, green:255, blue:255, alpha:0.7)
        sleepDurationLabel.font = UIFont(name: "MontserratAlternates", size: 14)
        let sleepDurationLabelYValue = self.view.center.y - 100
        sleepDurationLabel.frame = CGRect(x:0, y:sleepDurationLabelYValue, width:0, height:0)
        let rangeOfLargeFont = NSMakeRange(9, 12)
        let attributedString = NSMutableAttributedString(string:"You slept  10.0 hrs  last night")
        attributedString.setAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 36)!, NSAttributedString.Key.foregroundColor : UIColor.white], range: rangeOfLargeFont)
        sleepDurationLabel.attributedText = attributedString
        sleepDurationLabel.sizeToFit()
        sleepDurationLabel.frame.size = sleepDurationLabel.intrinsicContentSize
        
        sleepDurationLabel.center.x = self.view.center.x
        sleepDurationLabel.textAlignment = .center
        
        // questionLabel settings
        questionLabel.text = "Did you stay awake in bed?"
        questionLabel.textColor = UIColor(red:255, green:255, blue:255, alpha:0.7)
        questionLabel.font = UIFont(name: "MontserratAlternates", size: 14)
        questionLabelTopMargin.constant = self.view.center.y + 20
        
        // change buttonView size and label text
        yesButton.resize(width: 100, height: 100, textSize: 20)
        yesButton.setLabelWithText(text: "Yes")
        noButton.resize(width: 100, height: 100, textSize: 20)
        noButton.setLabelWithText(text: "No")
        
        self.view.setNeedsLayout()
    }
}
