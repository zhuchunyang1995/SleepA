//
//  beginSleepViewController.swift
//  
//
//  Created by Xiayi Sun on 10/18/18.
//

import UIKit

class beginSleepViewController: UIViewController {
    
    @IBOutlet weak var sleepButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundGradient = CAGradientLayer()
        let backgroundStartColor = UIColor(red:0.23, green:0.20, blue:0.52, alpha:1.0).cgColor
        let backgroundEndColor = UIColor(red:0.11, green:0.09, blue:0.30, alpha:1.0).cgColor
        backgroundGradient.frame = self.view.bounds
        backgroundGradient.colors = [backgroundStartColor, backgroundEndColor]
        self.view.layer.insertSublayer(backgroundGradient, at: 0)
        
        sleepButton.layer.cornerRadius = 0.5 * sleepButton.bounds.size.width
        sleepButton.layer.shadowColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4).cgColor
        sleepButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        sleepButton.layer.shadowOpacity = 0.5
        sleepButton.layer.shadowRadius = 10
        sleepButton.backgroundColor = .clear
        sleepButton.alpha = 0.4
        
//        sleepButton.backgroundColor = .clear
//        sleepButton.clipsToBounds = true
//        sleepButton.alpha = 0.4
//        sleepButton.layer.shadowColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4).cgColor
//        sleepButton.layer.shadowRadius = 10
        let buttonGradient = CAGradientLayer()
        let buttonStartColor = UIColor(red:0.21, green:0.18, blue:0.48, alpha:1.0).cgColor
        let buttonEndColor = UIColor(red:0.53, green:0.49, blue:0.78, alpha:1.0).cgColor
        buttonGradient.frame = sleepButton.bounds
        buttonGradient.colors = [buttonStartColor, buttonEndColor]
        buttonGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        buttonGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        sleepButton.layer.insertSublayer(buttonGradient, at: 0)
    }
}
