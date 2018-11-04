//
//  sleepDurationViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/19/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Parse

class sleepDurationViewController: sleepParentViewController, segueDelegate {

    @IBOutlet weak var sleepDurationLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionLabelTopMargin: NSLayoutConstraint!
    @IBOutlet weak var backButtonView: buttonView!
    
    var sleepDurationString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sleepDurationLabel settings
        sleepDurationLabel.textColor = UIColor(red:255, green:255, blue:255, alpha:0.7)
        sleepDurationLabel.font = UIFont(name: "MontserratAlternates", size: 14)
        let sleepDurationLabelYValue = self.view.center.y - 100
        sleepDurationLabel.frame = CGRect(x:0, y:sleepDurationLabelYValue, width:0, height:0)
        
        let string = "You slept  \(sleepDurationString)  hrs   last night"
        let length = sleepDurationString.count + 8
        let rangeOfLargeFont = NSMakeRange(9, length)
        let attributedString = NSMutableAttributedString(string:string)
        attributedString.setAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 36)!, NSAttributedString.Key.foregroundColor : UIColor.white], range: rangeOfLargeFont)
        sleepDurationLabel.attributedText = attributedString
        sleepDurationLabel.sizeToFit()
        sleepDurationLabel.frame.size = sleepDurationLabel.intrinsicContentSize
        
        sleepDurationLabel.center.x = self.view.center.x
        sleepDurationLabel.textAlignment = .center
        
        // questionLabel settings
        questionLabel.text = "☀️ Have a nice day!"
        questionLabel.textColor = UIColor(red:255, green:255, blue:255, alpha:0.7)
        questionLabel.font = UIFont(name: "MontserratAlternates", size: 14)
        questionLabelTopMargin.constant = self.view.center.y + 20
        
        // backButtonView settings
        backButtonView.resize(width: 100, height: 100, textSize: 20)
        backButtonView.setLabelWithText(text: "Back")
        backButtonView.viewControllerDelegate = self
    }
    
    func performSegueToNextVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
        
        //save data to backend
        if let user = PFUser.current() {
            user["lastNightSleepHour"] = Double(sleepDurationString)
            let sleephr = PFObject(className:"SleepHour")
            sleephr["user"] = user
            sleephr["sleepHour"] = Double(sleepDurationString)
            user.saveInBackground {
                (success, error) in
                if (success) {
                    // The object has been saved.
                    // ToDo: jump to the main page
                } else {
                    // There was a problem, check error.description
                }
            }
            sleephr.saveInBackground {
                (success, error) in
                if (success) {
                    // The object has been saved.
                    // ToDo: jump to the main page
                } else {
                    // There was a problem, check error.description
                }
            }
        }
        
        
        present(vc, animated: false, completion: nil)
    }
}
