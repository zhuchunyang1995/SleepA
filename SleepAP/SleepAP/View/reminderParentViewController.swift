//
//  reminderParentViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 11/11/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class reminderParentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "star1")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 1.0
        self.view.insertSubview(backgroundImageView, at: 0)
        
//        let backgroundGradient = CAGradientLayer()
//        backgroundGradient.frame = self.view.bounds
//        let backgroundTopColor = UIColor(red:0.07, green:0.18, blue:0.32, alpha:0.2).cgColor
//        let backgroundMiddleColor = UIColor(red:0.08, green:0.12, blue:0.33, alpha:0.2).cgColor
//        let backgroundBottomColor = UIColor(red:0.07, green:0.18, blue:0.32, alpha:0.2).cgColor
//        backgroundGradient.colors = [backgroundTopColor, backgroundMiddleColor, backgroundBottomColor]
//        backgroundGradient.locations = [0.0, 0.5, 1.0]
//        self.view.layer.insertSublayer(backgroundGradient, at: 1)
        
        let yValue : CGFloat
        if ((UIApplication.shared.keyWindow?.safeAreaInsets.top)! > CGFloat(20.0)) {
            yValue = 50
        } else {
            yValue = 30
        }
        
        let imageView = UIImageView(frame:CGRect(x: 20, y: yValue, width: 30, height: 30))
        imageView.image = UIImage(named:"cross")
        imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        imageView.addGestureRecognizer(tap)
    }
    
    // click cross will return to the tabBarViewController
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
        present(vc, animated: false, completion: nil)
    }
}
