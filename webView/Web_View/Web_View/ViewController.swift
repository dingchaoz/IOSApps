//
//  ViewController.swift
//  Web_View
//
//  Created by Dingchao Zhang on 1/10/16.
//  Copyright © 2016 Dingchao Zhang. All rights reserved.
//

import UIKit
import TwitterKit


class ViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                    message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

        
        
        
        let urlPath = "https://api.twitter.com/1.1/statuses/show.json?id=210462857140252672"
        
        //
        let url = NSURL(string: urlPath)
        
        // create a session to run a task within it
        let session = NSURLSession.sharedSession()
        
        // this part of task construction syntax is slightly different than the tutorial's
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            
            if (error != nil) {
                
                print(error)
            } else {
                
                let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                print(urlContent)
                
                // display the web view use content using request -- method1
                
//                self.webView.loadRequest(NSURLRequest(URL: url!))
                
                // Download the web html and display it - - method2
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    
//                    self.webView.loadHTMLString(String(urlContent!), baseURL: nil)
//
//                })
                
                
                
                // Try to get the jason serialized data of the web if possible, thus we have to use do {try} catch{}
                do {
                    
                     let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers)
                    
                    
                    print(jsonResult)
                    
                } catch {
                    
                    print("JSON serialization failed")
                }
                
               
                
            }
        }
        
        // run the task
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

