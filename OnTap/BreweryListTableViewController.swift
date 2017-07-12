//
//  BreweryListTableViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/23/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit

class BreweryListTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var breweryTableView: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    var fetchedBrewery = [Brewery]()
    var filteredBrewery = [Brewery]()
    var breweryPageNumber: Int = 1
    var isSearching: Bool = false

    

    override func viewDidLoad() {
        
        
        breweryTableView.dataSource = self
        breweryTableView.delegate = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        fetchBreweries()
        
        breweryTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        breweryTableView.separatorColor = UIColor .darkGray
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func filterTableView(text: String) {
        self.fetchedBrewery = fetchedBrewery.filter({(brewery) -> Bool in
            return brewery.name.lowercased().contains(text)
        })
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
        
        if isSearching {
            return filteredBrewery.count
        }
        // #warning Incomplete implementation, return the number of rows
        return fetchedBrewery.count
    }
    
    func fetchBreweries(page:Int=1) {

        guard let url = URL(string: "http://api.brewerydb.com/v2/breweries/?key=6ac28fb2b6b8ea4081184e492e5462d8&p=\(self.breweryPageNumber)")
            else {return }

        let session = URLSession.shared
        session.dataTask(with: url) {(data, response, error) in

        if let data = data {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    if let breweries = json["data"] as? [[String:Any]] {
                        for brewery in breweries {
                            let newBrewery = Brewery()
                            if let breweryId = brewery["id"] as? String {
                                newBrewery.id = breweryId
                            }
                            
                            if let breweryName = brewery["name"] as? String {
                                newBrewery.name = breweryName
                            }
                            
                            if let breweryWebsite = brewery["website"] as? String {
                                newBrewery.website = breweryWebsite
                            }
                            if let breweryDescription = brewery["description"] as? String {
                                newBrewery.description = breweryDescription
                            }
                            
                            if let breweryImages = brewery["images"] as? [String:String] {
                                let breweryImagePath = breweryImages["squareMedium"]
                                newBrewery.imagePath = breweryImagePath!
                            }
                            self.fetchedBrewery.append(newBrewery)
                        }
                    }
                }
            } catch {
                print(error)
            }
        self.breweryTableView.reloadData()
        self.breweryPageNumber += 1
        }
    }.resume()
}
    
    override func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = breweryTableView.dequeueReusableCell(withIdentifier: "breweryCell", for: indexPath)
        let text: String!
        
        if isSearching {
            text = filteredBrewery[indexPath.row].name
        } else {
            text = self.fetchedBrewery[indexPath.row].name
        }
        cell.textLabel?.text = text
        
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            self.breweryTableView.reloadData()
        } else {
            filteredBrewery = fetchedBrewery.filter({return $0.name == searchBar.text!})
            
            self.isSearching = true
            
            breweryTableView.reloadData()
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var isLoadingNewData: Bool = false
        
        if scrollView == breweryTableView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                if !isLoadingNewData {
                    isLoadingNewData = true
                    fetchBreweries()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "breweryDetailSegue",
            let destination = segue.destination as? BreweryDetailViewController,
            let breweryIndex = self.breweryTableView.indexPathForSelectedRow?.row
        {
            destination.breweryId = self.fetchedBrewery[breweryIndex].id
            destination.breweryName = self.fetchedBrewery[breweryIndex].name
            destination.breweryWebsite = self.fetchedBrewery[breweryIndex].website
            destination.breweryDescription = self.fetchedBrewery[breweryIndex].description
            destination.breweryImagePath = self.fetchedBrewery[breweryIndex].imagePath
        }
    }
}








