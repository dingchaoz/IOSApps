//
//  ViewController.swift
//  twitterAPI
//
//  Created by Dingchao Zhang on 1/12/16.
//  Copyright © 2016 Dingchao Zhang. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

//    @IBAction func showTweetsTapped(sender: AnyObject) {
//        
//        Twitter.sharedInstance().logInGuestWithCompletion { guestSession, error in
//            if (guestSession != nil) {
//                self.performSegueWithIdentifier("segueShowTweets", sender: self)
//            } else {
//                print("error: \(error!.localizedDescription)");
//            }
//        }
//        
//        
//        
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initiate a client in guest mode
        let client = TWTRAPIClient()
        
        //Load Multiple Tweets
        let tweetIDs = ["20", "510908133917487104"]
        client.loadTweetsWithIDs(tweetIDs) { (tweets, error) -> Void in
            // handle the response or error
            print(tweets!)
            print(tweets![0])
            
        }
        
        
        // Load a user
        client.loadUserWithID("12") { (user, error) -> Void in
            // handle the response or error
            print(user)
        }
        
        
        // Constructs a twitter request manually
        let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/show.json"
        let params = ["id": "20"]
        var clientError : NSError?
        
        let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod("GET", URL: statusesShowEndpoint, parameters: params, error: &clientError)
        
//        if request != nil {
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if (connectionError == nil) {
                    var jsonError : NSError?
                    
                    
                    // Try to get the jason serialized data of the web if possible, thus we have to use do {try} catch{}
                    do {
                        
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers)
                        
                        
                        print(jsonResult)
                        
                    } catch {
                        
                        print("JSON serialization failed")
                    }
                    
                    //let json : AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: nil)
                }
                else {
                    print("Error: \(connectionError)")
                }
            }
//        }
//        else {
//            print("Error: \(clientError)")
//        }
        
        
        // Get the current userID. This value should be managed by the developer but can be retrieved from the TWTRSessionStore.
//        if let userID = Twitter.sharedInstance().sessionStore.session()!.userID {
//            let client = TWTRAPIClient(userID: userID)
//            // make requests with client
//        }
        
        // Display tweets
        client.loadTweetWithID("631879971628183552") { (tweet, error) in
            if let unwrappedTweet = tweet {
                let tweetView = TWTRTweetView(tweet: unwrappedTweet)
                
                // Set the location of tweetview
                tweetView.center = CGPointMake(self.view.center.x, self.topLayoutGuide.length + tweetView.frame.size.height / 2);
                
                // Show action button
                tweetView.showActionButtons = true
                
                // Set the theme directly
                tweetView.theme = .Dark
                
                // Use custom colors
//                tweetView.primaryTextColor = UIColor.yellowColor()
//                tweetView.backgroundColor = UIColor.blueColor()
                
                // Set all future tweet views to use dark theme using UIAppearanceProxy
                TWTRTweetView.appearance().theme = .Dark
                
                // Use custom colors
//                TWTRTweetView.appearance().primaryTextColor = UIColor.yellowColor()
//                TWTRTweetView.appearance().backgroundColor = UIColor.blueColor()
//                TWTRTweetView.appearance().linkTextColor = UIColor.redColor()
                
                self.view.addSubview(tweetView)
            } else {
                NSLog("Tweet load error: %@", error!.localizedDescription);
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

