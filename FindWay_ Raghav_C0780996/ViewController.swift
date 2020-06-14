//
//  ViewController.swift
//  FindWay_ Raghav_C0780996
//
//  Created by Raghav Bobal on 2020-06-13.
//  Copyright © 2020 com.lambton. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate=self
        
        //giving the delegate of locationManager to this class
        locationManager.delegate = self
        
        // accuracy of the location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //req the user to grant location access
        locationManager.requestWhenInUseAuthorization()
        
        //start updating the location of the user
        locationManager.startUpdatingLocation()
        
        //1- define lat and long
        let latitude: CLLocationDegrees = 43.64
        let longitude: CLLocationDegrees = -79.38
        
        
          displayLocation(latitude: latitude, longitude: longitude, title: "Downtown,Toronto", subtitle: "beatiful city")
        
        
        //for long press gesture
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(addlongPressAnnotation))
        map.addGestureRecognizer(uilpgr)
        
        addDoubleTap()
        
        //MARK: - adds long press gesture recogniser for the annotation
        @objc func addlongPressAnnotation(gestureRecognizer: UIGestureRecognizer)
        {
            let touchPoint = gestureRecognizer.location(in: map)
            let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
            
            //add annotation
            let annotation = MKPointAnnotation()
            annotation.title = "My destination"
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
        }
        
        //MARK: - didupdatelocation method
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let userLocation = locations[0]
            
            let latitude = userLocation.coordinate.latitude
            let longitude = userLocation.coordinate.longitude
            
            displayLocation(latitude: latitude, longitude: longitude, title: "Your Location", subtitle: "This is where you are as of now")

        
        
        
        
    }
    
    

}

