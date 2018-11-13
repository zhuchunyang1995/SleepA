//
//  beginSleepViewController.swift
//  
//
//  Created by Xiayi Sun on 10/18/18.
//

import UIKit

class beginSleepViewController: sleepParentViewController, segueDelegate {

    @IBOutlet weak var sleepView: buttonView!
    @IBOutlet weak var additionalDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        additionalDescription.text = "😴 It’s time to go to sleep..."
        additionalDescription.textAlignment = .center
        additionalDescription.textColor = labelColor
        additionalDescription.font = UIFont(name: labelFontName, size: 18)
        
        sleepView.setLabelWithText(text: "Sleep")
        sleepView.viewControllerDelegate = self
        sleepView.setSegueName(text: "beginSleepSegue")
    }

    func performSegueToNextVC(segueName: String) {
        let date = Date()
        sleepStart = date
        performSegue(withIdentifier: sleepView.segueName, sender: nil)
    }
}
