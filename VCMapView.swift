//
//  VCMapView.swift
//  Recycler
//
//  Created by Ely on 8/17/15.
//  Copyright (c) 2015 Ely. All rights reserved.
//

import Foundation
import MapKit

extension   ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if let annotation = annotation as? Bin {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequedView.annotation = annotation
                view = dequedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            
            return view
        }
         return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        let location = view.annotation as! Bin
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
    
}
