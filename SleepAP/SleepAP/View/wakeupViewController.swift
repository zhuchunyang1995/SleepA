//
//  wakeupViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/19/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class wakeupViewController: sleepParentViewController, segueDelegate{

    @IBOutlet weak var wakeupView: buttonView!
    @IBOutlet weak var timerLabel: UILabel!
    var minutesElapsed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerLabel.text = "⏰ You slept 0.0 hours"
        timerLabel.textAlignment = .center
        timerLabel.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        timerLabel.font = UIFont(name: "MontserratAlternates", size: 14)
        
        wakeupView.setLabelWithText(text: "Wake Up")
        wakeupView.viewControllerDelegate = self
        wakeupView.setSegueName(text: "wakeUpSegue")
        
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(changeTimerLabel), userInfo: nil, repeats: true)
    }
    
    func performSegueToNextVC() {
        performSegue(withIdentifier: wakeupView.segueName, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sleepDurationVC = segue.destination as? sleepDurationViewController {
            sleepDurationVC.sleepDurationString = minutesToHourString(mins: minutesElapsed)
        }
    }
    
    @objc func changeTimerLabel() {
        minutesElapsed += 1
        timerLabel.text = "⏰ You slept " + minutesToHourString(mins: minutesElapsed) + " hours"
    }
    
    // MARK: Private helper functions
    func minutesToHourString(mins: Int)->String {
        let minutesToHour = Double(mins) / 60.0
        return minutesToHour.format(f: ".1")
    }
}
