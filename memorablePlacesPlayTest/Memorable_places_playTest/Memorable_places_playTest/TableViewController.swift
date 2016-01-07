//
//  TableViewController.swift
//  Memorable_places_playTest
//
//  Created by Dingchao Zhang on 1/6/16.
//  Copyright © 2016 Dingchao Zhang. All rights reserved.
//

import UIKit



// an array of dictionary defined in global space, so it can be used in all scripts
// this places variable is appended when users pined a place in map view and its content
// get displaced in this table view
var places = [Dictionary<String,String>()]

// keep track of which cell user tapped on, initially set to -1 which means user didn't add new place
var activePlace = -1

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if places.count == 1 {
            
            places.removeAll()
            
            places.append(["name":"Taj Mahal","lat":"27.175","lon":"78.04"])
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = places[indexPath.row]["name"]

        return cell
    }
    
    // The following lines need to be added, otherwise the table won't get updated
    // this is not in the video, but discussed by students and someone posted the solution
    override func viewWillAppear(animated:Bool){
        
        tableView.reloadData()
    }
    
    // this function performs when user clicks certain row on the table, very useful!
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        activePlace = indexPath.row
        
        return indexPath
    }
    
    // this function takes segue clicking as argument,
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "newPlace" {
            
            // rest activeplace when user is not tapping any place, but only wanted to add a new place
            // so this will bring the user's current location to the map
            activePlace = -1
            
        }
        
        
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
