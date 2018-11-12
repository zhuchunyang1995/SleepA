//
//  buttonView.swift
//  SleepAP
//
//  A reusable component of button with round border and gradient layer
//
//  Created by Xiayi Sun on 10/19/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

protocol segueDelegate {
    func performSegueToNextVC(segueName: String)
}

class buttonView: UIView {
    @IBOutlet var buttonView: UIView!
    @IBOutlet var button: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    var label = UILabel()
    var segueName : String = ""
    var viewControllerDelegate : segueDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "buttonView", bundle: nil).instantiate(withOwner: self, options: nil)
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        addSubview(buttonView)
        buttonView.frame = self.bounds
        
        buttonView.addSubview(backgroundView)
        backgroundView.layer.cornerRadius = 0.5 * backgroundView.bounds.size.width
        backgroundView.layer.shadowColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.3).cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.shadowRadius = 10
        backgroundView.backgroundColor = .clear
        
        backgroundView.addSubview(button)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        let buttonGradient = CAGradientLayer()
        let buttonStartColor = UIColor(red:0.41, green:0.58, blue:0.85, alpha:1.0).cgColor
        let buttonEndColor = UIColor(red:0.69, green:0.77, blue:0.95, alpha:1.0).cgColor
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
        label.font = UIFont(name: "Quicksand-Bold", size: 40)
        label.textColor = .white
        button.addSubview(label)
    }
    
    func resize(width: CGFloat, height: CGFloat, textSize: CGFloat) {
        self.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        buttonView.frame = self.bounds
        backgroundView.frame = self.bounds
        backgroundView.layer.cornerRadius = 0.5 * backgroundView.bounds.size.width
        button.frame = self.bounds
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        label.font = UIFont(name: "Quicksand-Bold", size: textSize)
        label.center = button.center
        label.textAlignment = .center
    }
    
    func setLabelWithText(text: String) {
        label.text = text
    }
    
    func setSegueName(text: String) {
        segueName = text
    }
    
    @IBAction func showNextViewController(_ sender: UIButton) {
        viewControllerDelegate.performSegueToNextVC(segueName: segueName)
    }
}
