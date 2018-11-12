//
//  sleepStartTimeViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 11/11/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class sleepStartTimeViewController: sleepParentViewController, segueDelegate {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var doneButton: buttonView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4)
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        
        questionLabel.text = "When did you fall asleep?"
        questionLabel.textColor = labelColor
        questionLabel.font = UIFont(name: labelFontName, size: 20)
        questionLabel.sizeToFit()
        
        doneButton.resize(width: 70, height: 70, textSize: 20)
        doneButton.setLabelWithText(text: "Done")
        doneButton.viewControllerDelegate = self
        doneButton.segueName = "doneSegue"
        
        datePickerView.setValue(labelColor, forKeyPath: "textColor")
        datePickerView.subviews[0].subviews[1].isHidden = true
        datePickerView.subviews[0].subviews[2].isHidden = true
    }
    
    func performSegueToNextVC(segueName: String) {
        sleepEnd = datePickerView.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: sleepStart, to: sleepEnd)
        sleepDurationString = convertToHourString(hour: components.hour!, mins: components.minute!)
        saveSleepHours()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
        present(vc, animated: false, completion: nil)
    }
}
