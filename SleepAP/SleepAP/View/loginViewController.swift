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
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var customButtonLogin: UIButton!
    @IBOutlet weak var customButtonSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let color1 = UIColor(rgb: 0x667eea)
        let color2 = UIColor(rgb: 0x764ba2)
        myView.setGradientBackground(colorOne: color1, colorTwo: color2)
        
        //buttons
        customButtonLogin.backgroundColor = UIColor.white
        customButtonSignup.backgroundColor = UIColor.white
        customButtonLogin.layer.cornerRadius = 7
        customButtonSignup.layer.cornerRadius = 7
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // After login, show the main board
    func loadHomeScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
        present(vc, animated: true, completion: nil)
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
                }
            }
        }
        
    }


}

