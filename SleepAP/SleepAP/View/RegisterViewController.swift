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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernmForReg.resignFirstResponder()
        pswdForReg.resignFirstResponder()
        pswdForComfirm.resignFirstResponder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    //actions
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
        
        if (pswdForComfirm.text! == pswdForReg.text!) {
            user.signUpInBackground {
                (succeeded, error) -> Void in
                if (error == nil) && (succeeded == true){
                    // sucessful!!
                    let storyboard = UIStoryboard(name: "Login", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "loginViewController") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                } else {
                    // Show the errorString somewhere and let the user try again.
                    let errorString = error!._userInfo?["error"] as? NSString
                    //TODO: show the error srting to the user
                    
                }
            }
        }
        
        
    }
}
