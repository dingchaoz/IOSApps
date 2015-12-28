//
//  ViewController.swift
//  Weather_Report
//
//  Created by Dingchao Zhang on 12/28/15.
//  Copyright © 2015 Dingchao Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var userCity: UITextField!
    
    
    @IBOutlet var cityWeather: UILabel!
    
    func showError() {
        
        cityWeather.text = "Was not able to find weather for" + userCity.text! + ". Please try again"
    }
    
    
    @IBAction func update(sender: AnyObject) {
        
        
        var url = NSURL(string: "http://www.weather-forecast.com/locations/London/forecasts/latest")
        
        // if url is a valid url
        if url != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                
                var urlError = false
                
                // if url works without error, proceed
                if error == nil {
                    
                    var urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    
                    print(urlContent)
                    
                    
                } else {
                    
                    urlError = true
                    
                }
                
                if urlError == true {
                    
                    self.showError()
                }
            })
            
        }
        
            // else if url is not valid
        else {
            
            showError()
        }
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

