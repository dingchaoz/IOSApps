//
//  StatusDetailViewController.swift
//  Live Updates
//
//  Created by Dingchao Zhang on 12/26/15.
//  Copyright © 2015 Dingchao Zhang. All rights reserved.
//

import UIKit

class StatusDetailViewController: UITableViewController {
    
    var status:String!
    
    
    @IBOutlet var statusDetailLabel: UILabel!
    
    override func viewDidLoad() {
        statusDetailLabel.text = status
        statusDetailLabel.numberOfLines = 0
        statusDetailLabel.sizeToFit()
    }

}
