//
//  ViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/20/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var menuShowing: Bool = false
    var myList = [BreweryLocation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadLocationData()
        
    }

    @IBAction func openMenu(_ sender: Any) {
        
        if(menuShowing) {
            leadingConstraint.constant = -161
            menuShowing = false
        } else {
            leadingConstraint.constant = 0
            menuShowing = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
        func loadLocationData() {
            guard let url = URL(string: "http://api.brewerydb.com/v2/locations/?key=6ac28fb2b6b8ea4081184e492e5462d8&p=1")
                else {return }
    
            let session = URLSession.shared
            session.dataTask(with: url) {(data, response, error) in
    
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            if let breweries = json["data"] as? [[String:Any]] {
                                for brewery in breweries {
                                    var newBrewery = BreweryLocation()
                                    if let latitude = brewery["latitude"] as? Double,
                                        let longitude = brewery["longitude"] as? Double{
                                        newBrewery.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                                    }
                                    if let breweryInfo = brewery["brewery"] as? [String:Any] {
                                        if let name = breweryInfo["name"] as? String {
                                            newBrewery.name = name
                                            newBrewery.title = name
                                        }
                                    }
                                    self.myList.append(newBrewery)
                                }
                            }
                        }
                    } catch {
                        print(error)
                    }
    
                }
        }.resume()
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("hello from mapSegue")
//        if segue.identifier == "mapSegue",
//            let destination = segue.destination as? BreweryMapViewController
//        {
//            destination.locationList = self.myList
//        }
//    }
}
