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
