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
    
    // After login, show the main board
    func loadHomeScreen(){
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
//        self.present(loginViewController, animated: true, completion: nil)
    }

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func login(_ sender: Any) {

    }

    @IBAction func signup(_ sender: Any) {

    }
}

