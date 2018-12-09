//
//  sleepStartTimeViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 11/11/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class sleepEndTimeViewController: sleepParentViewController, segueDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var doneButton: buttonView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4)
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        
        questionLabel.text = "When did you wake up?"
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
        saveSleepEndTime(sleepEndDate: datePickerView.date)
        let components = Calendar.current.dateComponents([.hour, .minute], from: getSleepStartDate(), to: getSleepEndDate())
        let sleepDurationString = convertToHourString(hour: components.hour!, mins: components.minute!)
        saveSleepHourDuration(sleepDurationString: sleepDurationString)
        
        let alert = UIAlertController(title: "Successed", message: "The sleeping hour duration and sleep start time are saved",  preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{action in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
            self.present(vc, animated: false, completion: nil)
        }))
        
        self.present(alert, animated: true)
    }
}
