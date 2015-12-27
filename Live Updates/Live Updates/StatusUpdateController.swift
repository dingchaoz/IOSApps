//
//  StatusUpdateController.swift
//  Live Updates
//
//  Created by Dingchao Zhang on 12/25/15.
//  Copyright © 2015 Dingchao Zhang. All rights reserved.
//

import UIKit

class StatusUpdateController: UIViewController {
    @IBOutlet var statusUpdateTextField: UITextField!

    @IBAction func updateStatusBtn(sender: AnyObject) {
        
        let status = statusUpdateTextField.text
        
        //PFObject *statusUpdate = [PFObject objectWithClassName,:"Status"];
        
        var statusUpdate:PFObject = PFObject(className: "Status")
        statusUpdate["newStatus"] = status
        statusUpdate["user"] = PFUser.currentUser()?.username
        
        /**
        statusUpdate.saveInBackgroundWithBlock {
            (isSuccesful: Bool!, error:NSError!)-> Void in
            if error == nil {
                
                print(isSuccesful)
            } else {
                
                print(error)
            }
        } **/
        
        statusUpdate.saveInBackgroundWithBlock {(succeeded: Bool, error: NSError?) -> Void in
            if error == nil {
                
                print(succeeded)
            } else {
                
                print(error)
            }
        
        }
               //statusUpdate.s
        /**
        if ((status?.isEmpty) != nil) {
            
            
        } else {
            
            var statusUpdate = PFObject(className: "Status")
            statusUpdate["newStatus"] = status
            statusUpdate["user"] = PFUser.currentUser()?.username
            /**
            statusUpdate.saveInBackgroundWithBlock({
                (isSuccessful: Bool!, error:NSError!) -> Void in
                if error == nil {
                    print("success")
                } else {
                    
                    print("error")
                }
                
            }) **/
           
            
        }
        **/
        
    }
}
