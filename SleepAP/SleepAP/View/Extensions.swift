//
//  Extensions.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/21/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func scaleImageToSize(image: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
