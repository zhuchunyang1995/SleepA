//
//  ReminderNavigationViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 11/11/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class ReminderNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers[0].hidesBottomBarWhenPushed = true;
    }
}
