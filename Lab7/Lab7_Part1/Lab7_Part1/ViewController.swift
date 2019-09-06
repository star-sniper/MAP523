//
//  ViewController.swift
//  Lab7_Part1
//
//  Created by Harshit Arora on 2019-07-10.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var tbLongitude: UITextField!
    @IBOutlet weak var tbLatitude: UITextField!
    @IBOutlet weak var tbAltitude: UITextField!
    @IBOutlet weak var tbCourse: UITextField!
    @IBOutlet weak var tbSpeed: UITextField!
    @IBOutlet weak var tfAddress: UITextView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //location[] contains and array that contains the trail of current locations
        //location[0] contains the last location
        let userLocation = locations[0]
        
        //We can extract the longitude and latitude of the location
        //Finally, we will update the map based on the existing location
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let altitude = userLocation.altitude
        let course = userLocation.course
        let speed = userLocation.speed
        
        tbLatitude.text = String(latitude)
        tbLongitude.text = String(longitude)
        tbAltitude.text = String(altitude)
        tbCourse.text = String(course)
        tbSpeed.text = String(speed)
        
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        //Reversing from longitude and latitude to Location (Physical Address)
        //Note: Any physical address can be mapped to a geographical longitude and latitude
        //However, the otherway around may not always be true. For istance:
        //A longitude and latitude in the middle of the ocean can not be mapped to any physical address :-(
        //In this case, the result will be "nil"
        //So, before displaying it, we need to check if the value is nil.
        //This has been reflected in the following code fragment
         var address = ""
        CLGeocoder().reverseGeocodeLocation(userLocation)
            
        { (placemarks, error) in
            
            if error != nil {
                print("error when reversing location")
            }
            else {
                
                
                if let placemark = placemarks?[0]{
                    
                   
                    
                    if placemark.subThoroughfare != nil {
                        
                        address += placemark.subThoroughfare! + " "
                        
                    }
                    
                    if  placemark.thoroughfare != nil {
                        
                        address += placemark.thoroughfare! + "\n"
                        
                    }
                    
                    if  placemark.subLocality != nil {
                        
                        address += placemark.subLocality! + "\n"
                        
                    }
                    
                    if  placemark.subAdministrativeArea != nil {
                        
                        address += placemark.subAdministrativeArea! + "\n"
                        
                    }
                    
                    if  placemark.postalCode != nil {
                        
                        address += placemark.postalCode! + "\n"
                        
                    }
                    
                    if placemark.country != nil {
                        
                        address += placemark.country! + "\n"
                        
                    }
                    self.tfAddress.text = String(address)
                    
                }
                
                
            }
            
         //   print(address)
            
            
        }
      //  tfAddress.text = String(address)
        
        
    }

}

