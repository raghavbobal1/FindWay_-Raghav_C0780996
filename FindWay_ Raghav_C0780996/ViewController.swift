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
               mapView.setRegion(coordinateRegion, animated: true)
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
            // Getting coordinate of double tapped point and adding annotation
             let locationInView = sender.location(in: map)
             let locationOnMap = map.convert(locationInView, toCoordinateFrom: map)
             addAnnotation(location: locationOnMap)
             getLocationInfo()
         }
    
    
    
    //MARK: - didupdatelocation method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        displayLocation(latitude: latitude, longitude: longitude, title: "Your Location", subtitle: "you are here")
        
        
    }
    
    //MARK: - display user location method
    func displayLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, subtitle: String) {
        // step 2 - define delta latitude and delta longitude for the span
        let latDelta: CLLocationDegrees = 0.5
        let lngDelta: CLLocationDegrees = 0.5
        
        // step 3 - creating the span and location coordinate and finally the region
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        
        // step 4 - set region for the map
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
    
    @objc func dropPin(sender: UITapGestureRecognizer)
    {
        removePin()
        
        // add annotation
        
        let touchPoint = sender.location(in: map)
        let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
        let annotation = MKPointAnnotation()
        annotation.title = "My destination"
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
    }
    
    func removePin() {
        for annotation in map.annotations {
            map.removeAnnotation(annotation)
        }
    }
}

extension ViewController: MKMapViewDelegate {
    //MARK: - add viewFor annotation method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        // add custom annotation with image
        let pinAnnotation = map.dequeueReusableAnnotationView(withIdentifier: "droppablePin") ?? MKPinAnnotationView()
        pinAnnotation.image = UIImage(named: "ic_place_2x")
        pinAnnotation.canShowCallout = true
        pinAnnotation.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return pinAnnotation
    }
    
    //MARK: - callout accessory control tapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let alertController = UIAlertController(title: "Your Place", message: "Welcome", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}


