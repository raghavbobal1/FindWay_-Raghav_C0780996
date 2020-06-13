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
        
    }


}

