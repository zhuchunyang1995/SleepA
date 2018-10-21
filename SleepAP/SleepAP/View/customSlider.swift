//
//  customSlider.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/21/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class customSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let rect: CGRect = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: slideBarHeight))
        super.trackRect(forBounds: rect)
        return rect
    }
}
