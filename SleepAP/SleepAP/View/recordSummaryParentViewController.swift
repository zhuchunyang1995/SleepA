//
//  recordSummaryParentViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 11/13/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class recordSummaryParentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "cloud5")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.3
        self.view.insertSubview(backgroundImageView, at: 0)
    }
}
