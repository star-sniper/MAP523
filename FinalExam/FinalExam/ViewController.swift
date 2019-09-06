//
//  ViewController.swift
//  FinalExam
//
//  Created by Harshit Arora on 2019-08-07.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

/*
 
 ANSWER1: PICKER VIEW DELEGATES USED: 1)func numberOfComponents(in pickerView: UIPickerView) -> Int
                                    2)func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
                                    3)func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:
                                    Int) -> String?
 ANSWER2: CLOSURE EXAMPLE:
 
 CLGeocoder().reverseGeocodeLocation(userLocation)
 { (placemarks, error) in
 
 }
 
 ANSWER3: (Float, Float) -> Int
 
 ANSWER4: func modifyInts(_ a: inout Int, _ b: inout Int) {
                a = someVal
                b = someVal2
        }
 */

import UIKit
import MapKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    let simpleTableIdentifier = "SimpleTableIdentifier"
    
    @IBOutlet weak var tblView: UITableView!
    
    var cell: UITableViewCell? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.default,
                reuseIdentifier: simpleTableIdentifier)
        }
        
        cell?.textLabel?.text = "No data"
        
        return cell!
    }
    

    @IBOutlet weak var btnAddPin: UIButton!
    @IBOutlet weak var campusPV: UIPickerView!
    
    @IBOutlet weak var mapView1: MKMapView!
    
    
    private let campusData = [
        "Seneca@York", "Seneca@Newnham", "York University"]
    
    private let zoomData = [
        -2, -1, 0, 1, 2 ]
    
    var coordinateArray: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 43.780938, longitude: -79.497475), CLLocationCoordinate2D(latitude: 43.7897001745, longitude: -79.3427602956), CLLocationCoordinate2D(latitude: 43.7705035846, longitude: -79.5021763246)]
    
    
    var selectedCoordinates: CLLocationCoordinate2D? = nil
    var selectedCampus: String = ""
    private let campusComp = 0
    private let zoomComp = 1
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (component == campusComp)
        {
            return campusData.count
        }
        else {
            return zoomData.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:
        Int) -> String? {
        
        if (component == campusComp){
            return campusData[row]
        }
        else {
            return String(zoomData[row])
        }
        
    }
    
    //LOCATE BUTTON CLICK
    @IBAction func btnCLick(_ sender: Any) {
        
        let campusRowSelected =
            campusPV.selectedRow(inComponent: campusComp)
        let zoomRowSelected =
            campusPV.selectedRow(inComponent: zoomComp)
        selectedCampus = campusData[campusRowSelected]
        let zoomVal = zoomData[zoomRowSelected]
        
        let getCd:  CLLocationCoordinate2D = coordinateArray[campusRowSelected]
        let latitude: CLLocationDegrees = getCd.latitude
        let longitude: CLLocationDegrees = getCd.longitude
        
        var zoomLevelConverted: Double = 0
        
        if(zoomVal == -2)
        {
            zoomLevelConverted = 0.2
        }
        else if(zoomVal == -1)
        {
             zoomLevelConverted = 0.1
        }
        else if(zoomVal == 0)
        {
            zoomLevelConverted = 0
        }
        else if(zoomVal == 1)
        {
            zoomLevelConverted = 0.002
        }
        else
        {
            zoomLevelConverted = 0.001
        }
        
        //zoom levels in X and Y direction
        let lanDelta = zoomLevelConverted
        let lonDelta = zoomLevelConverted
        
        //2 - A span to define a zoom level for the map
        let span = MKCoordinateSpan(latitudeDelta: lanDelta, longitudeDelta: lonDelta)
        
        //3 - Coordinate of the center of the map to be displayed on the screen
        selectedCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        //4 - Defining a region
        let region = MKCoordinateRegion(center: selectedCoordinates!, span: span)
        
        //DIsplay the map
        mapView1.setRegion(region, animated: true)
        
        cell?.textLabel?.text = selectedCampus
    }
    
    
    @IBAction func addPinClick(_ sender: Any) {
        
        if( selectedCoordinates?.longitude != nil)
        {
            let annotation  = MKPointAnnotation()
            if(selectedCampus == "Seneca@York")
            {
                annotation.title = "Seneca York"
            }
            else  if(selectedCampus == "Seneca@Newnham")
            {
                 annotation.title = "Seneca Newnham"
            }
            else
            {
                 annotation.title = "York U"
            }
            
            annotation.coordinate = selectedCoordinates!
            mapView1.addAnnotation(annotation)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        campusPV.selectRow(0, inComponent: 0, animated: true)
        campusPV.selectRow(2, inComponent: 1, animated: true)
    }


}

