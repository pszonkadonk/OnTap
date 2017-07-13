//
//  Brewery.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/24/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import Foundation
import MapKit

class Brewery: NSObject, MKAnnotation {
    var id: String
    var name: String
    var website: String
    var breweryDescription: String
    var imagePath: String
    var coordinate: CLLocationCoordinate2D
    
    override init() {
        self.id = ""
        self.name = ""
        self.website = ""
        self.breweryDescription = ""
        self.imagePath = ""
        coordinate = CLLocationCoordinate2D()
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.website = ""
        self.breweryDescription = ""
        self.imagePath = ""
        coordinate = CLLocationCoordinate2D()
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressSteetKey: self.name!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.name
        
        return mapItem
    }

}
