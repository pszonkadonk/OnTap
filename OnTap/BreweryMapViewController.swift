//
//  BreweryMapViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 7/16/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//
import UIKit
import MapKit

class BreweryMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 12000
    
    var locationList = [BreweryLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 40.74497292023281, longitude: -74.02436077594757)
        centerMapOnLocation(location: initialLocation)
        
        // Set Stevens Location
        
        let stevensLocation = BreweryLocation(name: "Stevens Institute of Technology",
                                              coordinate: CLLocationCoordinate2D(latitude: 40.74497292023281, longitude: -74.02436077594757))
        
        mapView.addAnnotations(locationList)
        mapView.addAnnotation(stevensLocation)
        mapView.delegate = self
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    
    
}
