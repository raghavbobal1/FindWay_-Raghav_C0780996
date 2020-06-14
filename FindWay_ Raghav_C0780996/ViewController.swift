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
\
            //MARK: - display user location method
               func displayLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, subtitle: String) {
                   // defining the delta latitude and delta longitude for the span
                   let latDelta: CLLocationDegrees = 0.05
                   let lngDelta: CLLocationDegrees = 0.05
                   
                   //creating the span and location coordinate and finally the region
                   let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
                   let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                   let region = MKCoordinateRegion(center: location, span: span)
                   
                   // set region for the map
                   map.setRegion(region, animated: true)
                   
                   // add annotation
                   let annotation = MKPointAnnotation()
                   annotation.title = title
                   annotation.subtitle = subtitle
                   annotation.coordinate = location
                   map.addAnnotation(annotation)
               }
        
            
            func addDoubleTap() {
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
                doubleTap.numberOfTapsRequired = 2
                map.addGestureRecognizer(doubleTap)
            }
            
            @objc func dropPin(sender: UITapGestureRecognizer) {
                removePin()
                
                // add annotation
                
                let touchPoint = sender.location(in: map)
                let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
                let annotation = MKPointAnnotation()
                annotation.title = "My destination"
                annotation.coordinate = coordinate
                map.addAnnotation(annotation)
            }
             
                func removePin()
                {
                    for annotation in map.annotations
                    {
                        map.removeAnnotation(annotation)
                    }
                }
            }

            
            
    }
        
    

}

