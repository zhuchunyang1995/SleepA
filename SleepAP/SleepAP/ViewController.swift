//
//  ViewController.swift
//  SleepAP
//
//  Created by Wu, Tianyuan on 10/16/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usernameText.text = ""
        passwdText.text = ""
        
    }
    override func viewDidAppear(_ animated: Bool){
        let currentUser = PFUser.current()
        if currentUser != nil {
            //@TODO
            loadHomeScreen()
        }
    }
    
    //After login, show the main board
    func loadHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "LoggedInViewController") as! LoggedInViewController
        self.present(loggedInViewController, animated: true, completion: nil)
    }

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwdText: UITextField!
    
    @IBAction func login(_ sender: Any) {
        
    }
    
    @IBAction func signup(_ sender: Any) {
        
    }
}

