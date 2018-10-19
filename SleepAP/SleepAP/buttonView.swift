//
//  buttonView.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/19/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class buttonView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "buttonView", bundle: nil).instantiate(withOwner: self, options: nil)
    }
}
