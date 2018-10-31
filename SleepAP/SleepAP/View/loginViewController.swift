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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usernameTextField.text = ""
        passwordTextField.text = ""
        
    }
    override func viewDidAppear(_ animated: Bool){
        let currentUser = PFUser.current()
        if currentUser != nil {
            //@TODO
            loadHomeScreen()
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

