//
//  beginSleepViewController.swift
//  
//
//  Created by Xiayi Sun on 10/18/18.
//

import UIKit

class beginSleepViewController: sleepRelatedViewController {
    

    @IBOutlet weak var sleepView: buttonView!
    @IBOutlet weak var additionalDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        additionalDescription.text = "😴 It’s time to go to sleep..."
        additionalDescription.textAlignment = .center
        additionalDescription.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        additionalDescription.font = UIFont(name: "MontserratAlternates", size: 14)
    }
}
