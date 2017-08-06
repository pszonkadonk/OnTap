//
//  BreweryDetailViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/24/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BreweryDetailViewController: UIViewController {

    @IBOutlet weak var breweryDetailView: UIView!
    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var breweryDescriptionLabel: UILabel!
    @IBOutlet weak var breweryWebsiteLabel: UILabel!
    @IBOutlet weak var breweryImageView: UIImageView!
    @IBOutlet weak var beerListButton: UIButton!
    
//    var dbRef: DatabaseReference?
    
    
//    @IBAction func favoriteButton(_ sender: Any) {
//        dbRef = Database.database().reference()
//        
//        dbRef?.child(<#T##pathString: String##String#>)
//    }

    
    var breweryId: String = ""
    var breweryName: String = ""
    var breweryWebsite: String = ""
    var breweryDescription: String = ""
    var breweryImagePath: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.breweryDescriptionLabel.text = breweryDescription
        self.breweryWebsiteLabel.text = breweryWebsite
        
        let breweryImageUrl = URL(string: breweryImagePath)
        if breweryImageUrl != nil {
            let data = try? Data(contentsOf: breweryImageUrl!)
            if let imageData = data {
                self.breweryImageView.image = UIImage(data: imageData)
            }
        } else {
            self.breweryNameLabel.text = breweryName
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "breweryBeerListSegue") {
            let destination = segue.destination as? BreweryBeerListTableViewController
            destination?.breweryId = self.breweryId
        }
        
        
    }
    

}
