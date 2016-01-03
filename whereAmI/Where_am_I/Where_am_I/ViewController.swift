//
//  ViewController.swift
//  Where_am_I
//
//  Created by Dingchao Zhang on 1/3/16.
//  Copyright © 2016 Dingchao Zhang. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    var locationManager:CLLocationManager!
    
    @IBOutlet var latitude: UILabel!
    @IBOutlet var longitude: UILabel!
    @IBOutlet var course: UILabel!
    @IBOutlet var speed: UILabel!
    @IBOutlet var altitude: UILabel!
    @IBOutlet var address: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
        
        let userLocation:CLLocation = locations[0] 
        
        self.latitude.text = "\(userLocation.coordinate.latitude)"
        
        self.longitude.text = "\(userLocation.coordinate.longitude)"
        
        self.course.text = "\(userLocation.course)"
        
        self.speed.text = "\(userLocation.speed)"
        
        self.altitude.text = "\(userLocation.altitude)"
        
        
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            if error != nil {
                
                print(error)
            }
            else {
                
                if let p = placemarks?.first {
                    
                    //print(p)
                    
                    var subThoroughfare:String = ""
                    //var thoroughfare:String = ""
                    
                    if (p.subThoroughfare != nil) {
                        
                        subThoroughfare = p.subThoroughfare!
                        
                    }
                    
                    /* there are optional word wrapped returned if no ! is added to the end of the p.thoroughfare for example, note we can't add ! to every p.thoroughfare directly, because some of them might return nil,
                        and that will return an error, the correct way should be as how we handle the p.subThoroughare above

                    */
                    
                    self.address.text = "\(subThoroughfare) \(p.thoroughfare) \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode!) \n \(p.country!)"
                }
            }
        }
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

