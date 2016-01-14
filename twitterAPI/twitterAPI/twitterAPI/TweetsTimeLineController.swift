//
//  TweetsTimeLineController.swift
//  twitterAPI
//
//  Created by Dingchao Zhang on 1/13/16.
//  Copyright © 2016 Dingchao Zhang. All rights reserved.
//

import UIKit
import TwitterKit


class TweetsTimeLineController: TWTRTimelineViewController {
    convenience init() {
        print("haha0")

        let client = Twitter.sharedInstance().APIClient
        let dataSource = TWTRUserTimelineDataSource(screenName: "fabric", APIClient: client)
        print("haha")

        
        self.init(dataSource: dataSource)
        print(dataSource)
    }
    
//    override required init(dataSource: TWTRTimelineDataSource) {
//        super.init(dataSource: dataSource)
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

//class TweetsTimeLineController: TWTRTimelineViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        
//        let client = TWTRAPIClient()
//        self.dataSource = TWTRUserTimelineDataSource(screenName: "fabric", APIClient: client)
//        
//        self.init(dataSource: dataSource)
//        
//        // Show Tweet actions
//        self.showTweetActions = true
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
