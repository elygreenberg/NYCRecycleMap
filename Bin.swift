//
//  Bin.swift
//  Recycler
//
//  Created by Ely on 8/17/15.
//  Copyright (c) 2015 Ely. All rights reserved.
//

import UIKit
import MapKit

class Bin: NSObject, MKAnnotation {
    
    let title: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate

        super.init()
    }
   
    
class func fromJSON(json: [JSONValue]) -> Bin? {
    
    var title: String
    
    if let titleOrNil = json[10].string {
        title = titleOrNil
    } else {
        title = ""
    }
    
    let latitude = (json[12].string! as NSString).doubleValue
    let longitude = (json[13].string! as NSString).doubleValue
    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    
    return Bin(title: title, coordinate: coordinate)
    }
    
    func mapItem() -> MKMapItem {
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    
}
