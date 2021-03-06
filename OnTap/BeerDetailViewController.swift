//
//  BeerDetailViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 7/1/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class BeerDetailViewController: UIViewController {
    
    var targetBeer: Beer = Beer()
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerAbvLabel: UILabel!
    @IBOutlet weak var beerStyleLabel: UILabel!
    @IBOutlet weak var beerIsOrganicLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    var dbRef: DatabaseReference!
    var currentUser = Auth.auth().currentUser!

    let strokeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName: UIColor.flatOrange,
        NSStrokeWidthAttributeName : -3.0,
        NSFontAttributeName : UIFont.boldSystemFont(ofSize: 47)
        ] as [String : Any]

    
    @IBAction func favoriteButton(_ sender: Any) {
        dbRef = Database.database().reference()
        self.dbRef.child("user").child(currentUser.uid+"/favoriteBeers/\(self.targetBeer.name)").observeSingleEvent(of: .value, with: { (snapshot) in
            if(snapshot.exists() == false) { //if not already favorited
                self.dbRef.child("user").child(self.currentUser.uid+"/favoriteBeers").updateChildValues([self.targetBeer.name:self.targetBeer.id])
                self.alertUser(title: "Favorited", message: "\(self.targetBeer.name) has been added to your favorites")
            } else {
                self.alertUser(title: "Nope", message: "\(self.targetBeer.name) is already in your favorites.")
            }
        })
    }
    
    override func viewDidLoad() {
        self.beerNameLabel.text = targetBeer.name
        self.beerAbvLabel.text = targetBeer.abv
        self.beerStyleLabel.text = targetBeer.style
        self.beerIsOrganicLabel.text = targetBeer.isOrganic
        
        if(targetBeer.description == "") {
            self.beerDescriptionLabel.text = "No Data Available"
        } else {
            self.beerDescriptionLabel.text = targetBeer.description
        }
        
        favoriteButton.layer.cornerRadius = 5
        favoriteButton.layer.borderWidth = 1
        
        beerImageView.layer.borderWidth = 1.0
        beerImageView.layer.borderColor = UIColor.black.cgColor
        
        beerNameLabel.textColor = UIColor.flatWhite
        beerAbvLabel.textColor = UIColor.flatWhite
        beerStyleLabel.textColor = UIColor.flatWhite
        beerIsOrganicLabel.textColor = UIColor.flatWhite

        beerNameLabel.textAlignment = NSTextAlignment.center
        beerAbvLabel.textAlignment = NSTextAlignment.center
        beerStyleLabel.textAlignment = NSTextAlignment.center
        beerIsOrganicLabel.textAlignment = NSTextAlignment.center
        
        if(targetBeer.imagePath != "") {
            let beerImageUrl = URL(string: targetBeer.imagePath)
            let data = try? Data(contentsOf: beerImageUrl!)
            if let imageData = data {
                self.beerImageView.image = UIImage(data: imageData)
            }
        } else {
            let filePath = Bundle.main.path(forResource: "placeholder", ofType: "png")
            self.beerImageView.image = UIImage(contentsOfFile: filePath!)
        }

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
