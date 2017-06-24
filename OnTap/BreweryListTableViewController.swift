//
//  BreweryListTableViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/23/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit

class BreweryListTableViewController: UITableViewController {
    
    @IBOutlet weak var breweryTableView: UITableView!
    
    
    
    var fetchedBrewery = [Brewery]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        breweryTableView.dataSource = self
        
        
        parseBreweries()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return fetchedBrewery.count
    }
    
    func parseBreweries() {
        
        fetchedBrewery = []
        
        guard let url = URL(string: "http://api.brewerydb.com/v2/breweries/?key=6ac28fb2b6b8ea4081184e492e5462d8")
            else {return}

        let session = URLSession.shared
        session.dataTask(with: url) {(data, response, error) in

        if let data = data {
            print(data)
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    if let breweries = json["data"] as? [[String:Any]] {
                        for brewery in breweries {
                            if let breweryName = brewery["name"] as? String {
                                var newBrewery = Brewery(name: breweryName)
                                self.fetchedBrewery.append(newBrewery)
                            }
                        }
                    }
                }
                self.breweryTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }.resume()
}
    

    
    override func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = breweryTableView.dequeueReusableCell(withIdentifier: "breweryCell", for: indexPath)

        cell.textLabel?.text = fetchedBrewery[indexPath.row].name
         

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


class Brewery {
    var name: String
    
    init() {
        self.name = ""
    }
    init(name: String) {
        self.name = name
    }
}




