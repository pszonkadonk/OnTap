//
//  Guild.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/4/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import Foundation

class Guild {
    var id: String
    var name : String
    var description: String
    var website: String
    var imageUrl: String
    
    
    init() {
        self.id = ""
        self.name = ""
        self.description = ""
        self.website = ""
        self.imageUrl = ""
    }
    
    init(id: String, name: String, description: String, website: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.description = description
        self.website = website
        self.imageUrl = imageUrl
    }
}
