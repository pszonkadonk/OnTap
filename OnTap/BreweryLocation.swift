//
//  BrewerLocation.swift
//  OnTap
//
//  Created by Michael Pszonka on 7/16/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import Foundation
import MapKit
import Contacts
import AddressBook

class BreweryLocation: NSObject, MKAnnotation {
    
    var title: String?
    var name: String
    var coordinate: CLLocationCoordinate2D
    
    
    override init() {
        self.name = ""
        self.title = ""
        self.coordinate = CLLocationCoordinate2D()
    }
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.title = name
        self.name = name
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return name
    }
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDictionary = [CNPostalAddressStreetKey: subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        
        return mapItem
    }
    
}
