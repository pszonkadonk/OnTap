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
import FirebaseAuth

class MainMenu: UIViewController {
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBAction func action(_ sender: UIButton) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "backToAuthSegue", sender: self )
    }
    
    var menuShowing: Bool = false
    var myList = [BreweryLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var count = 1
        while(count < 50) {
            loadLocationData(pageNumber: count)
            count+=1
        }
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
    
    func loadLocationData(pageNumber: Int) {
        guard let url = URL(string: "http://api.brewerydb.com/v2/locations/?key=6ac28fb2b6b8ea4081184e492e5462d8&p=\(pageNumber)")
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue",
            let destination = segue.destination as? BreweryMapViewController
        {
            destination.locationList = self.myList
        }
    }
}
