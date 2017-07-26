//
//  Hops.swift
//  OnTap
//
//  Created by Michael Pszonka on 7/25/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import Foundation


class Hops {
    
    var id: Int
    var name: String
    var description: String
    var alphaAcidMin: Int
    var betaAcidMin: Int
    var betaAcidMax: Int
    var humuleneMin: Int
    var humuleneMax: Int
    var caryophylleneMin: Int
    var caryophylleneMax: Int
    var cohumuloneMin: Int
    var cohumuloneMax: Int
    var myrceneMin: Int
    var myrceneMax: Int
    var farneseneMin: Int
    var farneseneMax: Int
    
    init() {
        self.id = 0
        self.name = ""
        self.description = ""
        self.alphaAcidMin = 0
        self.betaAcidMin = 0
        self.betaAcidMax = 0
        self.humuleneMin = 0
        self.humuleneMax = 0
        self.caryophylleneMin = 0
        self.caryophylleneMax = 0
        self.cohumuloneMin = 0
        self.cohumuloneMax = 0
        self.myrceneMin = 0
        self.myrceneMax = 0
        self.farneseneMin = 0
        self.farneseneMax = 0

    }
    
    init(id: Int, name: String, description: String, alphaAcidMin: Int, betaAcidMin: Int, betaAcidMax: Int,
        humuleneMin: Int, humuleneMax: Int, caryophylleneMin: Int, caryophylleneMax: Int, cohumuloneMin: Int,
        cohumuloneMax: Int, myrceneMin: Int, myrceneMax: Int, farneseneMin: Int, farneseneMax: Int) {
        
        self.id = id
        self.name = name
        self.description = description
        self.alphaAcidMin = alphaAcidMin
        self.betaAcidMin = betaAcidMin
        self.betaAcidMax = betaAcidMax
        self.humuleneMin = humuleneMin
        self.humuleneMax = humuleneMax
        self.caryophylleneMin = caryophylleneMin
        self.caryophylleneMax = caryophylleneMax
        self.cohumuloneMin = cohumuloneMin
        self.cohumuloneMax = cohumuloneMax
        self.myrceneMin = myrceneMin
        self.myrceneMax = myrceneMax
        self.farneseneMin = farneseneMin
        self.farneseneMax = farneseneMax
    }
    
    


    
    
}
