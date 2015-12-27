//
//  ViewController.swift
//  Live Updates
//
//  Created by Dingchao Zhang on 12/25/15.
//  Copyright © 2015 Dingchao Zhang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet var usernameLogin: UITextField!
    
    @IBOutlet var passwordLogin: UITextField!

    @IBAction func loginButton(sender: AnyObject) {
        
        let username = usernameLogin.text
        let password = passwordLogin.text
        
        if username!.isEmpty || password!.isEmpty {
            
        } else {
            //Login user in parse
            // Different from the tutorial the ? and ! marks usage
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user:PFUser?, error:NSError?) -> Void in
                if user != nil {
                    
                    // take user home
                    self.performSegueWithIdentifier("loginSuccessGoHome", sender: self)
                    
                } else {
                    
                    let errorAlert = UIAlertController(title: "Oops! Try again", message: "Error! Try again!", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }))
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                    
                }
            })
            
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Any time this page loads, clear the user
        PFUser.logOut()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

