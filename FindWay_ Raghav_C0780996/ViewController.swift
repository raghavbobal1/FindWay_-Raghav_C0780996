//
//  ViewController.swift
//  FindWay_ Raghav_C0780996
//
//  Created by Raghav Bobal on 2020-06-13.
//  Copyright © 2020 com.lambton. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var destination: CLLocationCoordinate2D!
    var taplocation: CLLocationCoordinate2D?
    var location: CLLocation?
    var latitude: CLLocationDegrees??
    var longitude: CLLocationDegrees??
    
    @IBOutlet weak var btnNav: UIButton!
    @IBOutlet weak var btnCar: UIButton!
    @IBOutlet weak var btnWalk: UIButton!
    @IBOutlet weak var btnZoomIn: UIButton!
    @IBOutlet weak var btnZoomOut: UIButton!
    @IBOutlet weak var map: MKMapView!

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //map delegate
        map.delegate=self
        
        //location delegate
        locationManager.delegate = self
        
        // accuracy of the location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // start updating the location of the user
        locationManager.startUpdatingLocation()
        
        // request the user for the location access
        locationManager.requestWhenInUseAuthorization()

        //disabling zoom tap
        map.isZoomEnabled = false
        
        //showing user location
        map.showsUserLocation = true
        
        // add double tap
        addDoubleTap()
        
    }
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
           {
               //to get the users location
               location = locations.first!
               let coordinateRegion = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 1000, longitudinalMeters:1000)
               map.setRegion(coordinateRegion, animated: true)
               locationManager.stopUpdatingLocation()
           }
    
    
    func addDoubleTap()
    {
        let doubleTapAdd = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapAdd.numberOfTapsRequired = 2
        map.addGestureRecognizer(doubleTapAdd)
    }
    
    @objc func doubleTap(sender: UITapGestureRecognizer)
         {
            // Getting coordinates of the tapped point to add annotation
             let locationInView = sender.location(in: map)
             let locationOnMap = map.convert(locationInView, toCoordinateFrom: map)
             addAnnotation(location: locationOnMap)
             getLocationInfo()
         }
    
    func addAnnotation(location: CLLocationCoordinate2D)
           {
               //Removing previous annotations and route
               self.map.removeOverlays(self.map.overlays)
               let oldAnnotations = self.map.annotations
               self.map.removeAnnotations(oldAnnotations)
               
               //Adding new annotation
               let annotation = MKPointAnnotation()
               annotation.coordinate = location
               latitude = annotation.coordinate.latitude
               longitude = annotation.coordinate.longitude
               annotation.title = "Your Dstination"
               
               self.map.addAnnotation(annotation)
           }
    
    

    
  
