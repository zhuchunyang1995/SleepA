//
//  SleepNavigationViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/28/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class SleepNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers[0].hidesBottomBarWhenPushed = true;
    }
}
