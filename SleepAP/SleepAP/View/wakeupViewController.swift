//
//  wakeupViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/19/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class wakeupViewController: sleepParentViewController {

    @IBOutlet weak var wakeupView: buttonView!
    @IBOutlet weak var additionalDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        additionalDescription.text = "🔆 It’s time to fulfill your whole day..."
        additionalDescription.textAlignment = .center
        additionalDescription.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        additionalDescription.font = UIFont(name: "MontserratAlternates", size: 14)
        
        wakeupView.setLabelWithText(text: "Wake Up")
    }

}
