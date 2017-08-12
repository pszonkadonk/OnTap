//
//  BreweryBeerListTableViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/29/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import Alamofire
import ChameleonFramework

class BreweryBeerListTableViewController: UITableViewController {

    @IBOutlet weak var beerListTableView: UITableView!
    
    var fetchedBeerList = [Beer]()
    var breweryId: String = ""
    
    override func viewDidLoad() {
        
        beerListTableView.dataSource = self
        beerListTableView.delegate = self
        
        fetchedBeers()

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
        return fetchedBeerList.count
    }
    
    func fetchedBeers() {
        Alamofire.request("http://api.brewerydb.com/v2/brewery/\(breweryId)/beers/?key=6ac28fb2b6b8ea4081184e492e5462d8").responseJSON { response in

        if let json = response.result.value as? [String:Any] {
            if let beerList = json["data"] as? [[String:Any]] { //core data
                for beer in beerList {
                    let newBeer = Beer()
                    if let newBeerId = beer["id"] as? String {
                        newBeer.id = newBeerId
                    }
                    if let newBeerName = beer["name"] as? String {
                        newBeer.name = newBeerName
                    }
                    if let isOrganic = beer["isOrganic"] as? String {
                        newBeer.isOrganic = isOrganic
                    }
                    if let beerLabels = beer["labels"] as? [String:Any] { //label data
                        if let beerLabel = beerLabels["medium"] as? String {
                            newBeer.imagePath = beerLabel
                        }
                    }
                    if let beerStyle = beer["style"] as? [String:Any] { //style data
                        if let beerABV = beerStyle["abvMax"] as? String {
                            newBeer.abv = beerABV
                        }
                        if let beerDescription = beerStyle["description"] as? String {
                            newBeer.description = beerDescription
                        }
                        if let style = beerStyle["shortName"] as? String {
                            newBeer.style = style
                        }
                        if let styleId = beerStyle["id"] as? String {
                            newBeer.styleId = styleId
                        }
                    }
                    self.fetchedBeerList.append(newBeer)
                }
            }
        self.beerListTableView.reloadData()
        }
    }
}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = beerListTableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        let text: String!
        
        text = fetchedBeerList[indexPath.row].name
        cell.textLabel?.text = text
        cell.backgroundColor = UIColor.flatSkyBlue
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.flatOrange
        cell?.backgroundColor = UIColor.flatOrange
        cell?.accessoryView?.backgroundColor = UIColor.flatOrange
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.flatSkyBlue
        cell?.backgroundColor = UIColor.flatSkyBlue
        cell?.accessoryView?.backgroundColor = UIColor.flatSkyBlue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "beerDetailSegue",
            let destination = segue.destination as? BeerDetailViewController,
            let beerIndex = self.beerListTableView.indexPathForSelectedRow?.row
        {
            destination.targetBeer = self.fetchedBeerList[beerIndex]
        }
    }    
}
