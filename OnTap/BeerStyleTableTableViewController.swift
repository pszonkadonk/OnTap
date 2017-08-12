//
//  BeerStyleTableTableViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/1/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import Alamofire

class BeerStyleTableTableViewController: UITableViewController {

    @IBOutlet weak var beerStyleTableView: UITableView!
    
    
    var fetchedBeerStyles = [BeerStyle]()
    
    
    override func viewDidLoad() {
        
        fetchBeerStyles()
        super.viewDidLoad()
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
        return fetchedBeerStyles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerStyleCell", for: indexPath)
        let text: String!
        
        text = self.fetchedBeerStyles[indexPath.row].name
        cell.textLabel?.text = text
        
        return cell
    }
 
    func fetchBeerStyles() {
        Alamofire.request("http://api.brewerydb.com/v2/styles/?key=6ac28fb2b6b8ea4081184e492e5462d8").responseJSON { response in
            if let json = response.result.value as? [String:Any] {
                if let beerStyles = json["data"] as? [[String:Any]] {
                    for style in beerStyles {
                        let newStyle = BeerStyle()
                        if let name = style["name"] as? String {
                            newStyle.name = name
                        }
                        
                        if let description = style["description"] as? String {
                            newStyle.description = description
                        }
                        print(newStyle.name)
                        self.fetchedBeerStyles.append(newStyle)
                    }
                }
            }
        self.beerStyleTableView.reloadData()
        }
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "beerStyleDetailSegue",
            let destination = segue.destination as? BeerStyleDetailViewController,
            let beerStyleIndex = self.beerStyleTableView.indexPathForSelectedRow?.row
        {
            destination.beerStyleName = self.fetchedBeerStyles[beerStyleIndex].name
            destination.beerStyleDescription = self.fetchedBeerStyles[beerStyleIndex].description
        }
        
    }
    

}
