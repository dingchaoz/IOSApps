//
//  ViewController.swift
//  Memorable_places_playTest
//
//  Created by Dingchao Zhang on 1/6/16.
//  Copyright © 2016 Dingchao Zhang. All rights reserved.
//

import UIKit
import MapKit



class ViewController: UIViewController,CLLocationManagerDelegate {
    
    // Define manager varibale to the type of CLLocation so that we can get user core location information
    var manager:CLLocationManager!

    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // Initiate manager variable and assign the value of CLLocationManager function
        // we delege the manager variable to the class self
        manager = CLLocationManager()
        
        manager.delegate = self
        
        // set up the accuracy of user loation
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        // if user didn't tap any places, use the user's location to show the map
        if activePlace == -1 {
            
            // request user authorization when in use
            manager.requestWhenInUseAuthorization()
            
            // start updating user location
            manager.startUpdatingLocation()
            
            
          // if user tapped on a place in the table, then bring that map to the map view
        } else {
            
            let latitude = NSString(string: places[activePlace]["lat"]!).doubleValue
            
            let longitude = NSString(string: places[activePlace]["lon"]!).doubleValue
            
            let coordiante = CLLocationCoordinate2DMake(latitude, longitude)
            
            let latDelta:CLLocationDegrees = 0.01
            
            let lonDelta:CLLocationDegrees = 0.01
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            
            let region:MKCoordinateRegion = MKCoordinateRegionMake(coordiante, span)
            
            self.map.setRegion(region, animated: true)
            
            
            // bring up the attonation that user pinged to the map
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = coordiante
            
            annotation.title = places[activePlace]["name"]
            
            self.map.addAnnotation(annotation)
            
        }
        
  
        
        
        // create gesture recognizer, targeting to this class and it will triger a function called action
        // which is defined outside the viewdidload()
        let uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        // press longer than 2.0 seconds then it is a long press gesture
        uilpgr.minimumPressDuration = 2.0
        
        map.addGestureRecognizer(uilpgr)
        
        
    }
    
    
    // function taking the long pressed gesture as argument
    func action(gestureRecognizer:UIGestureRecognizer) {
        
        // to avoid multiple touches, the function perform when a long press gesture begins
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            
            print("touched")
            
            // get the touch point in the map
            let touchPoint = gestureRecognizer.locationInView(self.map)
            
            // convert the touch point to a coordinate
            let newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            
            // initially define title as an empty string, and the title will be assigned value in the reversegeocoder function
            var title = ""
            
            // The following lines are to reversely get the nearest location address from the user's current coordinate
            
            // reverse geocoder requires CLLocation type as one of the input arguments, so here we form up a variable called
            // location using the user's current coordinate
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            // this is where reverse geo code occurs, and annotation is appended to map
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                // if no error returns
                if (error == nil) {
                    
                    // if there are placemarks returned near the location
                    if let p = placemarks?[0] {
                        
                        var subThoroughfare:String = ""
                        var thoroughfare:String = ""
                        
                        if p.subThoroughfare != nil {
                            
                            subThoroughfare = p.subThoroughfare!
                        }
                        
                        if p.thoroughfare != nil {
                            
                            thoroughfare = p.thoroughfare!
                        }
                        
                        // the titile will be the place marks' address
                        title = "\(subThoroughfare) \(thoroughfare)"
                    }
                    
                    
                }
                
                // otherwise, no placemarks returned, then we just add a time stamp as the title
                if title == "" {
                    
                    title = "Added \(NSDate())"
                }
                
                places.append(["name":title,"lat":"\(newCoordinate.latitude)","lon":"\(newCoordinate.longitude)"])
                
                // Create annotation, assign annotation title, coordinate, and add it to the map(a red pin)
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = newCoordinate
                
                annotation.title = title
                
                self.map.addAnnotation(annotation)
                
                print(title)
                
                print(annotation)
                
                
            })
            
            
            
            
        }
    
    }
    
    
    
    
    
    // locationManager is a predefined function type in swift, it takes the CLLocation variable and let
    // developer define actions to perform in certain conditions, in the following example, we define what
    // the app performs when user didUpdateLocations
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] 
        
        let latitude = userLocation.coordinate.latitude
        
        let longitude = userLocation.coordinate.longitude
        
        let coordiante = CLLocationCoordinate2DMake(latitude, longitude)
        
        let latDelta:CLLocationDegrees = 0.01
        
        let lonDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coordiante, span)
        
        self.map.setRegion(region, animated: true)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

