//
//  BreweryDetailViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/24/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class BreweryDetailViewController: UIViewController {

    @IBOutlet weak var breweryDetailView: UIView!
    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var breweryWebsiteLabel: UILabel!
    @IBOutlet weak var breweryImageView: UIImageView!
    @IBOutlet weak var beerListButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var breweryDescriptionLabel: UILabel!
    
    var breweryId: String = ""
    var breweryName: String = ""
    var breweryWebsite: String = ""
    var breweryDescription: String = ""
    var breweryImagePath: String = ""
    
    
    var dbRef: DatabaseReference!    
    var currentUser = Auth.auth().currentUser!
    
    @IBAction func favoriteButton(_ sender: Any) {
        
        dbRef = Database.database().reference()
        self.dbRef.child("user").child(currentUser.uid+"/favoriteBreweries/\(self.breweryName)").observeSingleEvent(of: .value, with: { (snapshot) in
            if(snapshot.exists() == false) { //if not already favorited
                self.dbRef.child("user").child(self.currentUser.uid+"/favoriteBreweries").updateChildValues([self.breweryName:self.breweryId])
                self.alertUser(title: "Favorited", message: "\(self.breweryName) has been added to your favorites")
            } else {
                self.alertUser(title: "Nope", message: "\(self.breweryName) is already in your favorites.")
            }
        })
    }

    override func viewDidLoad() {
        
        favoriteButton.layer.cornerRadius = 5
        favoriteButton.layer.borderWidth = 1
        beerListButton.layer.cornerRadius = 5
        beerListButton.layer.borderWidth = 1
        
        breweryDescriptionLabel.textColor = UIColor.flatWhite
        breweryWebsiteLabel.textColor = UIColor.flatWhite
        self.breweryDescriptionLabel.text = breweryDescription
        self.breweryWebsiteLabel.text = breweryWebsite
    
        let breweryImageUrl = URL(string: breweryImagePath)
        if breweryImageUrl != nil {
            let data = try? Data(contentsOf: breweryImageUrl!)
            if let imageData = data {
                self.breweryImageView.image = UIImage(data: imageData)
                breweryImageView.layer.borderWidth = 1.0
                breweryImageView.layer.borderColor = UIColor.black.cgColor
            }
        } else {
            self.breweryNameLabel.text = breweryName
        }
        
        super.viewDidLoad()
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
    
    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    

}
