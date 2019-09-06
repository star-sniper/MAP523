//
//  ViewController.swift
//  Lab7_Part2
//
//  Created by Harshit Arora on 2019-07-21.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView1: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView1.showsUserLocation = true
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        mapView1.delegate = self
        mapView1.mapType = .standard
        mapView1.isZoomEnabled = true
        mapView1.isScrollEnabled = true
        
        if let coor = mapView1.userLocation.location?.coordinate{
            mapView1.setCenter(coor, animated: true)
        }
        // Do any additional setup after loading the view.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        /*let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapView1.mapType = MKMapType.standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView1.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "My location"
        annotation.subtitle = "current location"
        mapView1.addAnnotation(annotation)
        */
        //centerMap(locValue)
    }
}

