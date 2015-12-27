//
//  RegisterViewController.swift
//  Live Updates
//
//  Created by Dingchao Zhang on 12/25/15.
//  Copyright © 2015 Dingchao Zhang. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var usernameTextFiled: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    /**sign up button**/
    @IBAction func signUpButton(sender: AnyObject) {
        
        let username = usernameTextFiled.text
        
        let email = emailTextField.text
        
        let password = passwordTextField.text
        
        // check if not empty, then store in parse
        if username!.isEmpty || email!.isEmpty || password!.isEmpty {
            
            // an empty field exists alert user.
            
        } else {
            
            // success, store user in parse
            /** start of adding user**/
            let user = PFUser()
            user.username = username
            user.password = password
            user.email = email
            //user["phone"] = "415-392-0202"
            // other fields can be set just like with PFObject
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if  error == nil {
                    print("success haha")                    // Show the errorString somewhere and let the user try again.
                    
                    // Take user home
                    self.performSegueWithIdentifier("takeUserHome", sender: self)
                } else {
                    // Hooray! Let them use the app now.
                    print("error")
                }
            }
        }
       
       /** end of adding user**/
        
    }
    
}
