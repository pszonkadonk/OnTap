//
//  FavoriteBreweryTableViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/10/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class FavoriteBreweryTableViewController: UITableViewController {
    
    
    var dbRef: DatabaseReference!
    var currentUser = Auth.auth().currentUser!
    var favoriteBreweries = [Brewery]()
    @IBOutlet weak var favoriteBreweryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFavoriteBreweries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteBreweries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteBreweryCell", for: indexPath)
        
        let text: String!
        text = self.favoriteBreweries[indexPath.row].name
        cell.textLabel?.text = text
        
        return cell
    }
    
    func fetchFavoriteBreweries() {
        dbRef = Database.database().reference()
        self.dbRef.child("user").child(currentUser.uid+"/favoriteBreweries/").observeSingleEvent(of: .value, with: { (snapshot) in
            if let breweryDictionary = snapshot.value as? [String:String] {
                for (key, element) in breweryDictionary {
                    var newBrewery = Brewery()
                    newBrewery.name = key
                    newBrewery.id = element
                    self.favoriteBreweries.append(newBrewery)
                }
            }
            DispatchQueue.main.async(execute: {
                self.favoriteBreweryTableView.reloadData()
            })
        })
    }
    
    //row deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let breweryName = self.favoriteBreweries[indexPath.row].name
        
        if editingStyle == .delete {
            
            self.dbRef.child("user").child(currentUser.uid+"/favoriteBreweries/")
                .child(breweryName).removeValue(completionBlock: { (error, dbRef) in
                    if(error != nil) { //failed to remove brewery
                        return
                    }
                    
                    // remove the item from the data model
                    self.favoriteBreweries.remove(at: indexPath.row)
                    
                    // delete the table view row
                    tableView.deleteRows(at: [indexPath], with: .fade)
                })
        }
    }
}
