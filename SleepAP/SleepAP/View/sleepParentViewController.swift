//
//  sleepParentViewController.swift
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
        
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "cloud")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.7
        self.view.insertSubview(backgroundImageView, at: 0)
        
        let backgroundGradient = CAGradientLayer()
        backgroundGradient.frame = self.view.bounds
        let backgroundTopColor = UIColor(red:0.42, green:0.59, blue:0.93, alpha:0.2).cgColor
        let backgroundMiddleColor = UIColor(red:0.65, green:0.73, blue:0.92, alpha:0.2).cgColor
        let backgroundBottomColor = UIColor(red:0.75, green:0.82, blue:0.91, alpha:0.2).cgColor
        backgroundGradient.colors = [backgroundTopColor, backgroundMiddleColor, backgroundBottomColor]
        backgroundGradient.locations = [0.0, 0.5, 1.0]
        self.view.layer.insertSublayer(backgroundGradient, at: 1)
        
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
