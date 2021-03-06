//
//  Brewery.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/24/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import Foundation
import MapKit

class Brewery {
    var id: String
    var name: String
    var website: String
    var breweryDescription: String
    var imagePath: String
    
    init() {
        self.id = ""
        self.name = ""
        self.website = ""
        self.breweryDescription = ""
        self.imagePath = ""
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.website = ""
        self.breweryDescription = ""
        self.imagePath = ""
    }
}
