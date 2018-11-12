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

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sleepDurationLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var noButton: buttonView!
    @IBOutlet weak var yesButton: buttonView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4)
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: sleepStart, to: sleepEnd)
        sleepDurationString = convertToHourString(hour: components.hour!, mins: components.minute!)
        
        // sleepDurationLabel settings
        sleepDurationLabel.text = "You slept \(sleepDurationString) hrs"
        sleepDurationLabel.textColor = labelColor
        sleepDurationLabel.font = UIFont(name: labelFontName, size: 25)
        sleepDurationLabel.sizeToFit()
        sleepDurationLabel.frame.size = sleepDurationLabel.intrinsicContentSize
        
        // questionLabel settings
        questionLabel.text = "Is that accurate?"
        questionLabel.textColor = labelColor
        questionLabel.font = UIFont(name: labelFontName, size: 22)
        
        // button view settings
        yesButton.resize(width: 70, height: 70, textSize: 20)
        yesButton.setLabelWithText(text: "Yes")
        yesButton.viewControllerDelegate = self
        yesButton.segueName = "yesSegue"
        noButton.resize(width: 70, height: 70, textSize: 20)
        noButton.setLabelWithText(text: "No")
        noButton.viewControllerDelegate = self
        noButton.segueName = "noSegue"
        
        divider.backgroundColor = labelColor
    }
    
    func performSegueToNextVC(segueName: String) {
        if (segueName == "noSegue") {
            performSegue(withIdentifier: noButton.segueName, sender: nil)
        } else if (segueName == "yesSegue") {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
            present(vc, animated: false, completion: nil)
            saveSleepHours()
        }
    }
}
