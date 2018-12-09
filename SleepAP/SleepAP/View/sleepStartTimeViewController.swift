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
    @IBOutlet weak var nextButton: buttonView!
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
        
        nextButton.resize(width: 70, height: 70, textSize: 20)
        nextButton.setLabelWithText(text: "Next")
        nextButton.viewControllerDelegate = self
        nextButton.segueName = "nextSegue"
        
        datePickerView.setValue(labelColor, forKeyPath: "textColor")
        datePickerView.subviews[0].subviews[1].isHidden = true
        datePickerView.subviews[0].subviews[2].isHidden = true
    }
    
    func performSegueToNextVC(segueName: String) {
        let pickerDate = datePickerView.date
        let sleepStartTime = pickerDate.addingTimeInterval(-24*60*60)
        saveSleepStartTime(sleepStartDate: sleepStartTime)
        performSegue(withIdentifier: nextButton.segueName, sender: nil)
    }
}
