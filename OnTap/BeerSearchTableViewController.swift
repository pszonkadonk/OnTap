//
//  BeerSearchTableViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/7/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import Alamofire
import ChameleonFramework

class BeerSearchTableViewController: UITableViewController {

    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var beerSearchTableView: UITableView!
    
    var fetchedBeers = [Beer]()
    var beerPageNumber: Int = 1
    
    
    @IBAction func searchBeer(_ sender: Any) {
        
        fetchedBeers.removeAll()
        queryBeers()
    }
    
    override func viewDidLoad() {
        
        searchBarTextField.attributedPlaceholder = NSAttributedString(string: "Search for a beer", attributes: [NSForegroundColorAttributeName: UIColor.flatWhite])
        searchBarTextField.textColor = UIColor.flatWhite

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
        return fetchedBeers.count
    }
    
    
    
    
    func queryBeers(page: Int = 1) {
        Alamofire.request("http://api.brewerydb.com/v2/search?q=\(searchBarTextField.text!)&type=beer&p=\(self.beerPageNumber)&key=6ac28fb2b6b8ea4081184e492e5462d8").responseJSON { response in
            if let json = response.result.value as? [String:Any] {
                if let guilds = json["data"] as? [[String:Any]] {
                    if let searchedBeers = json["data"] as? [[String: Any]] { //core data
                        for beer in searchedBeers {
                            let newBeer = Beer()
                            if let newBeerId = beer["id"] as? String {
                                newBeer.id = newBeerId
                            }
                            if let newBeerName = beer["name"] as? String {
                                newBeer.name = newBeerName
                                print(newBeer.name)
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
                        self.fetchedBeers.append(newBeer)
                        }
                    }
                }
                if(self.fetchedBeers.count == 0) {
                    self.alertUser(title: "No Data", message: "There are no search results for \(self.searchBarTextField.text!)")
                }
                else {
                    self.beerSearchTableView.reloadData()
                    self.beerPageNumber += 1
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerSearchCell", for: indexPath)

        let text: String!
        text = fetchedBeers[indexPath.row].name
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
    
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var isLoadingNewData: Bool = false
        
        if scrollView == beerSearchTableView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                if !isLoadingNewData {
                    isLoadingNewData = true
                    queryBeers()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "beerDetailSegue",
            let destination = segue.destination as? BeerDetailViewController,
            let beerIndex = self.beerSearchTableView.indexPathForSelectedRow?.row
        {
            destination.targetBeer = self.fetchedBeers[beerIndex]
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
