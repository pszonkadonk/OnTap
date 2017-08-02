//
//  BeerStyle.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/1/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import Foundation

class BeerStyle {

    var name: String
    var description: String
    
    init() {
        self.name = ""
        self.description = ""
    }
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
}
