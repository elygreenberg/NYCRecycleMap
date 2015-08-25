//
//  ViewController.swift
//  NYCRecycleMap
//
//  Created by Ely on 8/25/15.
//  Copyright (c) 2015 Erg Process Energy, LLC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
// import Parse

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    // Location of Noble Desktop
    // 40.724915,-73.996985
    
    var bins = [Bin]()
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set initially location
        let initialLocation = CLLocation(latitude: 40.724915, longitude: -73.996985)
        
        centerMapOnLocation(initialLocation)
        
        // Show users location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MKUserTrackingMode.Follow
        
        // load bin data and show markers
        loadData()
        mapView.addAnnotations(bins)
        
        mapView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Check user permission to use location
        checkLocationAuthorizationStatus()
    }
        
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func loadData() {
        let fileName = NSBundle.mainBundle().pathForResource("RecyclingLocations", ofType: "json")
        var readError: NSError?
        var data: NSData = NSData(contentsOfFile: fileName!, options: NSDataReadingOptions(0), error: &readError)!
        
        var error: NSError?
        let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error)
        
        if let jsonObject = jsonObject as? [String: AnyObject] where error == nil,
            let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
                for binJSON in jsonData {
                    if let binJSON = binJSON.array,
                        bin = Bin.fromJSON(binJSON){
                            bins.append(bin)
                    }
                }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

