////
////  BreweryMapViewController.swift
////  OnTap
////
////  Created by Michael Pszonka on 7/11/17.
////  Copyright © 2017 Michael Pszonka. All rights reserved.
////
//
//import UIKit
//import MapKit
//import CoreLocation
//
//class BreweryMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
//
//    @IBOutlet weak var map: MKMapView!
//    var manager = CLLocationManager()
//    var breweryList = [Brewery]()
//    
//    
//    
//    @IBAction func ZoomToUserLocation() {
//        if let coordinate = map.userLocation.location?.coordinate {
//            let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
//            map.setRegion(region, animated: true)
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        map.delegate = self
//        manager.delegate = self
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//        self.breweryList = loadLocationData()
//        print(breweryList)
//        map.addAnnotations(breweryList)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        map.showsUserLocation = (status == .authorizedWhenInUse)
//    }
//    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if let annotation = annotation as? Brewery {
//            let identifier = "breweryPin"
//            var view: MKPinAnnotationView
//            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//                as? MKPinAnnotationView {
//                dequeuedView.annotation = annotation
//                view = dequeuedView
//            } else {
//                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                view.canShowCallout = true
//                view.calloutOffset = CGPoint(x: -5, y: 5)
//                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
//            }
//            
//            view.pinTintColor = MKPinAnnotationView.greenPinColor()
//            //			view.image=UIImage(named: "x")
//            return view
//        }
//        return nil
//    }
//    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        let location = view.annotation as! Brewery
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        location.mapItem().openInMaps(launchOptions: launchOptions)
//    }
//
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func loadLocationData() -> [Brewery] {
//        var myList = [Brewery]()
//        guard let url = URL(string: "http://api.brewerydb.com/v2/locations/?key=6ac28fb2b6b8ea4081184e492e5462d8&p=1")
//            else {return [Brewery()] }
//        
//        let session = URLSession.shared
//        session.dataTask(with: url) {(data, response, error) in
//        
//            if let data = data {
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
//                        if let breweries = json["data"] as? [[String:Any]] {
//                            for brewery in breweries {
//                                let newBrewery = Brewery()
//                                if let latitude = brewery["latitude"] as? Double,
//                                    let longitude = brewery["longitude"] as? Double{
//                                    newBrewery.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
//                                }
//                                if let breweryInfo = brewery["brewery"] as? [String:Any] {
//                                    if let id = breweryInfo["id"] as? String {
//                                        newBrewery.id = id
//                                    }
//                                    if let name = breweryInfo["name"] as? String {
//                                        newBrewery.name = name
//                                    }
//                                }
//                                myList.append(newBrewery)
//                            }
//                        }
//                    }
//                } catch {
//                    print(error)
//                }
//
//            }
//    }.resume()
//        return myList
//}
//    
//
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
