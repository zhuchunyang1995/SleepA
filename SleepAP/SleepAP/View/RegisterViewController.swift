//
//  RegisterViewController.swift
//  SleepAP
//
//  Created by tianyuan wu on 2018/10/27.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {
    // outlets
    @IBOutlet weak var usernmForReg: UITextField!
    @IBOutlet weak var pswdForReg: UITextField!
    @IBOutlet weak var pswdForComfirm: UITextField!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var signUpBt: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let color1 = UIColor(rgb: 0x667eea)
        let color2 = UIColor(rgb: 0x764ba2)
        myView.setGradientBackground(colorOne: color1, colorTwo: color2)
        signUpBt.backgroundColor = UIColor.white
        signUpBt.layer.cornerRadius = 7
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

    func showLogin () {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernmForReg.resignFirstResponder()
        pswdForReg.resignFirstResponder()
        pswdForComfirm.resignFirstResponder()
    }
    //actions
    @IBAction func goBack(_ sender: Any) {
        self.showLogin()
    }
    @IBAction func signUp(_ sender: Any) {
        //check if username and password are nil
        
        if (usernmForReg.text == nil) || (pswdForReg.text == nil) || (pswdForComfirm.text == nil) {
            //TODO
            //do sth to notice the user to do it again
            return
        }
        
        let user = PFUser()
        user.username = usernmForReg.text!
        user.password = pswdForReg.text!
        user.email = usernmForReg.text!
        user["last7SleepHour"] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
        user["last7AverageScore"] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
        user["reminderOn"] = false
        user["reminderTime"] = "00:00 AM"
        user["weeklyHour"] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
        user["weeklyScore"] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
        
        if (pswdForComfirm.text! == pswdForReg.text!) {
            user.signUpInBackground {
                (succeeded, error) -> Void in
                if (error == nil) && (succeeded == true){
                    let alert = UIAlertController(title: "Success", message: "Please check your email for the verification",  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        self.showLogin()
                    }))
                    
                    self.present(alert, animated: true)
                    
                } else {
                    // Show the errorString somewhere and let the user try again.
                    let errorString = error!._userInfo?["error"] as? NSString
                    //TODO: show the error srting to the user
                    let alert = UIAlertController(title: "SignUp Failed", message: errorString! as String,  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        self.usernmForReg.text = ""
                        self.pswdForReg.text = ""
                        self.pswdForComfirm.text = ""
                    }))
                    self.present(alert, animated: true)
                    
                }
            }
            
            
        }
        
        else {
            let errorString = "Two input passwords are diffrerent"
            //TODO: show the error srting to the user
            let alert = UIAlertController(title: "SignUp Failed", message: errorString as String,  preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.usernmForReg.text = ""
                self.pswdForReg.text = ""
                self.pswdForComfirm.text = ""
            }))
            self.present(alert, animated: true)
        }
        
        
    }
}
