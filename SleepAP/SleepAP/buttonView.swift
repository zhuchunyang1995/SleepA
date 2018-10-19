//
//  buttonView.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/19/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

class buttonView: UIView {
    @IBOutlet var buttonView: UIView!
    @IBOutlet var button: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    var label = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "buttonView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(buttonView)
        buttonView.frame = self.bounds
        
        buttonView.addSubview(backgroundView)
        backgroundView.layer.cornerRadius = 0.5 * backgroundView.bounds.size.width
        backgroundView.layer.shadowColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4).cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        backgroundView.layer.shadowOpacity = 1
        backgroundView.layer.shadowRadius = 10
        backgroundView.backgroundColor = .clear
        
        backgroundView.addSubview(button)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        let buttonGradient = CAGradientLayer()
        let buttonStartColor = UIColor(red:0.21, green:0.18, blue:0.48, alpha:0.4).cgColor
        let buttonEndColor = UIColor(red:0.53, green:0.49, blue:0.78, alpha:0.4).cgColor
        buttonGradient.colors = [buttonStartColor, buttonEndColor]
        buttonGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        buttonGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        buttonGradient.frame = button.bounds
        button.layer.insertSublayer(buttonGradient, at: 0)
        button.clipsToBounds = true

        label.frame = CGRect(x: 0, y: 90, width: 200, height:50)
        label.center = button.center
        label.textAlignment = .center
        label.text = "Sleep"
        label.font = UIFont(name: "Roboto-Medium", size: 36)
        label.textColor = .white
        button.addSubview(label)
    }
}
