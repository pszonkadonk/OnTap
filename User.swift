//
//  User.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/6/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import Foundation

class User {
    
    var email: String
    var favoriteBreweries = [Brewery]()
    var favoriteBeers = [Beer]()
    
    init(email: String) {
        self.email = email
        self.favoriteBeers = []
        self.favoriteBeers = []
    }
    
    func mutateUserObject() -> Any {
        return ["email": email, "favoriteBreweries": false, "favoriteBeers": false]
    }
    
    
    
}
