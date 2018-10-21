//
//  sleepRelatedViewController.swift
//  SleepAP

//  This class serves as a super class for other view controllers with a blue
//  gradient background, so that other VC don't need to set backgorund every time.
//
//  Created by Xiayi Sun on 10/19/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class sleepParentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundGradient = CAGradientLayer()
        let backgroundStartColor = UIColor(red:0.23, green:0.20, blue:0.52, alpha:1.0).cgColor
        let backgroundEndColor = UIColor(red:0.11, green:0.09, blue:0.30, alpha:1.0).cgColor
        backgroundGradient.frame = self.view.bounds
        backgroundGradient.colors = [backgroundStartColor, backgroundEndColor]
        self.view.layer.insertSublayer(backgroundGradient, at: 0)
    }
}
