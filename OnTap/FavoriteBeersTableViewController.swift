//
//  FavoriteBeersTableViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/9/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class FavoriteBeersTableViewController: UITableViewController {
    
    var dbRef: DatabaseReference!
    var currentUser = Auth.auth().currentUser!
    var favoriteBeers = [Beer]()
    @IBOutlet weak var favoriteBeerTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFavoriteBeers()
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
        return favoriteBeers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteBeerCell", for: indexPath)

        let text: String!
        text = self.favoriteBeers[indexPath.row].name
        cell.textLabel?.text = text

        return cell
    }
    
    func fetchFavoriteBeers() {
        dbRef = Database.database().reference()
        self.dbRef.child("user").child(currentUser.uid+"/favoriteBeers/").observeSingleEvent(of: .value, with: { (snapshot) in
            if let beerDictionary = snapshot.value as? [String:String] {
                for (key, element) in beerDictionary {
                    var newBeer = Beer()
                    newBeer.name = key
                    newBeer.id = element
                    self.favoriteBeers.append(newBeer)
                }
            }
            DispatchQueue.main.async(execute: {
                self.favoriteBeerTableView.reloadData()
            })
        })
    }
    
    
    //row deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let beerName = self.favoriteBeers[indexPath.row].name
        
        if editingStyle == .delete {
            
            self.dbRef.child("user").child(currentUser.uid+"/favoriteBeers/")
                .child(beerName).removeValue(completionBlock: { (error, dbRef) in
                    if(error != nil) { //failed to removebeer
                         return
                    }
                    
                    // remove the item from the data model
                    self.favoriteBeers.remove(at: indexPath.row)
                    
                    // delete the table view row
                    tableView.deleteRows(at: [indexPath], with: .fade)
                })
        }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
