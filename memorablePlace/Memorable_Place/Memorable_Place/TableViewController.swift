//
//  TableViewController.swift
//  Memorable_Place
//
//  Created by Dingchao Zhang on 1/3/16.
//  Copyright © 2016 Dingchao Zhang. All rights reserved.
//

import UIKit

var places = [Dictionary<String,String>()]

var activePlace = -1

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if places.count == 1 {
            
            places.removeAtIndex(0)
            
            places.append(["name":"Taj Mahal","lat":"27.175277","lon":"78.042128"])
            
            places.append(["name":"Test example","lat":"37.175277","lon":"98.042128"])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableview: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return places.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = places[indexPath.row]["name"]
        
        print(places.count)
        
        return cell
        
       
        
    }
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        activePlace = indexPath.row
        
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "newPlace" {
            
            activePlace = -1
        }
    }

}
