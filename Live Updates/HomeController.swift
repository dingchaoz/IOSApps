//
//  HomeController.swift
//  Live Updates
//
//  Created by Dingchao Zhang on 12/25/15.
//  Copyright © 2015 Dingchao Zhang. All rights reserved.
//

import UIKit

class HomeController: UIViewController,UITableViewDelegate {
    
    
    @IBOutlet var homeTableView: UITableView!
    
    var myObjects = [PFObject]()
    var userNames = [String]()
    var userStatuses = [String]()
    
    override func viewDidLoad() {
        //query all status objects
        let queryStatus = PFQuery(className: "Status")
        
        queryStatus.orderByDescending("createdAt")
        
        // Different from the tutorial
        queryStatus.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                self.myObjects = objects!
                print(self.myObjects)
                for object in self.myObjects {
                    self.userNames.append(object["user"]as! String)
                    self.userStatuses.append(object["newStatus"]as! String)
                }
                // reload data
                self.homeTableView.reloadData()
            } else {
                
                // no objects found
            }
        }
        
        
    }
    /**
    override func viewDidLayoutSubviews() {
        //check if user is logged in else log out user
        let currentUser = PFUser.currentUser()
        if currentUser == nil {
            performSegueWithIdentifier("logOut", sender: self)
        }
    }
    **/
    /** number of rows **/
    func tableView(tableView:UITableView!,numberOfRowsInSection section: Int) -> Int {
        
        return myObjects.count
    }
    
    /** populating each cell **/
    func tableView(tableView:UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell? {
        
        // Different from the tutorial
        let mycell:StatusCell = tableView.dequeueReusableCellWithIdentifier("statusCell") as! StatusCell!
        
        mycell.usernameLabel.text = self.userNames[indexPath.row]
        mycell.statusLabel.text = self.userStatuses[indexPath.row]
        return mycell
        
        
    }
    
    /** on table row item click **/
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // open the storyboard with id statusDetailViewStory and send it some data
        let viewController: StatusDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("statusDetailViewStory") as! StatusDetailViewController
        
        viewController.status = userStatuses[indexPath.row]
        self.presentViewController(viewController, animated: true, completion: nil)
        
    }
    

}
