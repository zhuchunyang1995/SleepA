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
    func loadSingUpScreen(){
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as UIViewController
        present(vc, animated: false, completion: nil)
    }

    @IBAction func skipSingup(_ sender: Any) {
        PFUser.logOut()
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            let query = PFUser.query()
            query!.whereKey("username", equalTo:uuid)
            query!.findObjectsInBackground {
                (objects, error) -> Void in
                if error == nil {
                    // The find succeeded.
                    if ((objects != nil) && (objects!.count > 0)) {
                        let user = objects![0] as! PFUser
                        PFUser.logInWithUsername(inBackground: user.username!, password: "000") {
                            (user, error) -> Void in
                            if let loggeduser = user {
                                self.loadHomeScreen()
                            }
                        }
                        
                    }
                    else {
                        let user = PFUser()
                        user.username = uuid
                        user.password = "000"
                        user["last7SleepHour"] = []
                        user["last7AverageScore"] = []
                        user["reminderOn"] = false
                        user["daysHourScoreObjectArray"] = []
                        user["reminderTime"] = "00:00 AM"
                        user["weeklyHour"] = []
                        user["weeklyScore"] = []
                        
                        user.signUpInBackground {
                            (succeeded, error) -> Void in
                            if (error == nil) && (succeeded == true){
                                //logint
                                PFUser.logInWithUsername(inBackground: uuid, password: "000") {
                                    (user, error) -> Void in
                                    if let loggeduser = user {
                                        self.loadHomeScreen()
                                    }
                                }
                                
                            }
                        }
                    }
                }
                else {
                    print(error!._userInfo?["error"] as? String)
                }
                
            }
        }
        else {
            let alert = UIAlertController(title: "Something's Wrong", message: "Sorry but you could not skip the login process",  preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        if (usernameTextField.text != nil) && (passwordTextField.text != nil) {
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) {
                (user, error) -> Void in
                if let loggeduser = user {
                    if loggeduser["emailVerified"] as! Bool == false {
                        // Not verified email
                        let alert = UIAlertController(title: "Email not verified", message: "Please check the verification email",  preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }

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

