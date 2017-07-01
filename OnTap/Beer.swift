//
//  Beer.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/29/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import Foundation
class Beer {
    var id: String
    var name: String
    var isOrganic: String
    var description: String
    var abv: String
    var style: String
    var styleId: String
    var imagePath: String
    
    init() {
        self.id = ""
        self.name = ""
        self.isOrganic = ""
        self.description = ""
        self.abv = ""
        self.style = ""
        self.styleId = ""
        self.imagePath = ""

    }
}
