//
//  ViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/20/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var menuShowing: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    @IBAction func getData(_ sender: Any) {
        guard let url = URL(string: "http://api.brewerydb.com/v2/beer/oeGSxs?key=6ac28fb2b6b8ea4081184e492e5462d8") else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) {(data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let beerData = json["data"] as? [String:Any] {
                            print(beerData["abv"] as! String)
                            if let beerStyle = beerData["style"] as? [String:Any] {
                                print(beerStyle["description"] as! String)
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

