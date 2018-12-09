//
//  wakeupViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/19/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Parse

class wakeupViewController: sleepParentViewController, segueDelegate{

    @IBOutlet weak var wakeupView: buttonView!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerLabel.text = "🤤 Have a nice dream!"
        timerLabel.textAlignment = .center
        timerLabel.textColor = labelColor
        timerLabel.font = UIFont(name: labelFontName, size: 18)
        
        wakeupView.setLabelWithText(text: "Wake")
        wakeupView.viewControllerDelegate = self
        wakeupView.setSegueName(text: "wakeUpSegue")
    }
    
    func performSegueToNextVC(segueName: String) {
        saveSleepEndTime(sleepEndDate: Date())
        performSegue(withIdentifier: wakeupView.segueName, sender: nil)
    }
}
