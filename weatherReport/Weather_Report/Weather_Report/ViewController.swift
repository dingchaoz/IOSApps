//
//  ViewController.swift
//  Weather_Report
//
//  Created by Dingchao Zhang on 12/31/15.
//  Copyright © 2015 Dingchao Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userCity: UITextField!
    
    @IBAction func update(sender: AnyObject) {
        
        
        // url to fetch web
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + userCity.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        // If URL exists
        if url != nil{
            
            var urlError = false
            
            var weather = ""
            
            // Initiate a task to return data, response and error
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
                (data,response,error) -> Void in
                
                // if no error returned
                if error == nil {
                    
                    let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                    
                    let urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0 {
                        
                        let weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0] as String
                        
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "o")
                    }
                    
                    //print(urlContent)
                }
                else {
                    
                    urlError = true
                    
                    
                }
                
                
                if urlError == true {
                    
                    self.showError()
                    
                } else {
                    
                    self.result.text = weather
                }
                
            })
            
            task.resume()
            
        } else {
            
            showError()
            
        }

        
        
    }
    
    @IBOutlet var result: UILabel!
    
    func showError() {
       
        result.text = "Was not able to find weather for" + userCity.text! + "please try again"
        
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

