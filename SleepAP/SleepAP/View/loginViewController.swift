//
//  ViewController.swift
//  SleepAP
//
//  Created by Wu, Tianyuan on 10/16/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Parse

class loginViewController: UIViewController {
    // outlets

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var customButtonLogin: UIButton!
    @IBOutlet weak var customButtonSignup: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //background
        let color1 = UIColor(rgb: 0x667eea)
        let color2 = UIColor(rgb: 0x764ba2)
        myView.setGradientBackground(colorOne: color1, colorTwo: color2)
        
        //buttons
        customButtonLogin.backgroundColor = UIColor.white
        customButtonSignup.backgroundColor = UIColor.white
        customButtonLogin.layer.cornerRadius = 7
        customButtonSignup.layer.cornerRadius = 7
        
        //textfields
        let emailIcon = UIImage(named: "email")
        let passwdIcon = UIImage(named: "password")
        self.addIconToTextField(txtField: usernameTextField, icon: emailIcon!)
        self.addIconToTextField(txtField: passwordTextField, icon: passwdIcon!)
        usernameTextField.text = ""
        passwordTextField.text = ""
        
        
        
    }
    override func viewDidAppear(_ animated: Bool){
        let currentUser = PFUser.current()
        if currentUser != nil {
            //@TODO
            //loadHomeScreen()
        }
    }
    
    func addIconToTextField (txtField: UITextField, icon: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: -1.0, y: 0.0, width: icon.size.width * 0.45, height: icon.size.height * 0.45))
        iconView.image = icon
        txtField.leftView = iconView
        txtField.leftViewMode = .always
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // After login, show the main board
    func loadHomeScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
        present(vc, animated: false, completion: nil)
    }

    
    @IBAction func login(_ sender: Any) {
        if (usernameTextField.text != nil) && (passwordTextField.text != nil) {
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) {
                (user, error) -> Void in
                if let loggeduser = user {
                    //@TODO
                    self.loadHomeScreen()
                } else {
                    // The login failed. Check error to see why.
                    // TODO: tell the user about the failure
                    let errorString = error!._userInfo?["error"] as? NSString
                    //TODO: show the error srting to the user
                    let alert = UIAlertController(title: "LogIn Failed", message: errorString! as String,  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        self.usernameTextField.text = ""
                        self.passwordTextField.text = ""
                    }))
                    self.present(alert, animated: true)
                }
            }
        }
        
    }


}

