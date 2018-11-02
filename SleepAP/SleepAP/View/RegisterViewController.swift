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
    
    func showLogin () {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
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
        
        if (pswdForComfirm.text! == pswdForReg.text!) {
            user.signUpInBackground {
                (succeeded, error) -> Void in
                if (error == nil) && (succeeded == true){
                    // sucessful!!
                    self.showLogin()
                   
                } else {
                    // Show the errorString somewhere and let the user try again.
                    let errorString = error!._userInfo?["error"] as? NSString
                    //TODO: show the error srting to the user
                    
                }
            }
        }
        
        
    }
}
