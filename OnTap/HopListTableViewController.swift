//
//  HopListTableViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 7/25/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit

class HopListTableViewController: UITableViewController {

    @IBOutlet weak var hopsTableView: UITableView!
    var fetchedHops = [Hops]()
    var hopsPages: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hopsTableView.dataSource = self
        hopsTableView.delegate = self
        hopsPages = getHopsPages()
        print(hopsPages)
        
        for i in 1...hopsPages {
            fetchHops(pageNumber: i)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    func fetchHops(pageNumber: Int) {
        guard let url = URL(string: "http://api.brewerydb.com/v2/breweries/?key=6ac28fb2b6b8ea4081184e492e5462d8&p=\(pageNumber)")
            else {return }
        
        let session = URLSession.shared
        session.dataTask(with: url) {(data, response, error) in
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let hops = json["data"] as? [[String:Any]] {
                            for hops in hopsList {
                                let newHops = Hops()
                                if hops.description != nil {
                                    if let id = hopsList["id"] as? Int {
                                        newHops.id = hopsId
                                    }
                                    
                                    if let name = hopsList["name"] as? String {
                                        newHops.name = hopsName
                                    }
                                    
                                    if let description = hopsList["description"] as? String {
                                        newHops.description = breweryWebsite
                                    }
                                    if let alphaAcidMin = hopsList["alphaAcidMin"] as? Int {
                                        newHops.alphaAcidMin = alphaAcidMin
                                    }

                                    if let betaAcidMin = hopsList["betaAcidMin"] as? Int {
                                        newHops.betaAcidMin = betaAcidMin
                                    }
                                    
                                    if let betaAcidMax = hopsList["betaAcidMax"] as? Int {
                                        newHops.betaAcidMax = betaAcidMax
                                    }
                                    
                                    if let humuleneMin = hopsList["humuleneMin"] as? Int {
                                        newHops.humuleneMin = humuleneMin
                                    }
                                    
                                    if let humuleneMax = hopsList["humuleneMax"] as? Int {
                                        newHops.humuleneMax = hopsList["humuleneMax"]
                                    }
                                    
                                    if let caryophylleneMin = hopsList["caryophylleneMin"] as? Int {
                                        newHops.caryophylleneMin = caryophylleneMin
                                    }
                                    
                                    if let caryophylleneMax = hopsList["caryophylleneMax"] as? Int {
                                        newHops.caryophylleneMax = caryophylleneMax
                                    }
                                    
                                    if let cohumuloneMin = hopsList["cohumuloneMin"] as? Int {
                                        newHops.cohumuloneMin = cohumuloneMin
                                     }
                                    
                                    if let cohumuloneMax = hopsList["cohumuloneMax"] as? Int {
                                        newHops.cohumuloneMax = cohumuloneMax
                                    }
                                    
                                    if let myrceneMin = hopsList["myrceneMin"] as? Int {
                                        newHops.myrceneMin = myrceneMin
                                    }
                                    
                                    if let myrceneMax = hopsList["myrceneMax"] as? Int {
                                        newHops.myrceneMax = myrceneMax
                                    }
                                    
                                    if let farneseneMin = hopsList["farneseneMin"] as? Int {
                                        newHops.farneseneMin = farneseneMin
                                    }
                                    
                                    if let farneseneMax = hopsList["farneseneMax"] as? Int {
                                        newHops.farneseneMax = farneseneMax
                                    }
                                    
                                    self.fetchedHops.append(newHops)
                                }
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
    
    func getHopsPages() -> Int {
        var pageNum = 0
        guard let url = URL(string: "http://api.brewerydb.com/v2/hops/?key=6ac28fb2b6b8ea4081184e492e5462d8")
            else {return 0}
        
        let session = URLSession.shared
        session.dataTask(with: url) {(data, response, error) in
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let pages = json["numberOfPages"] as? Int {
                            pageNum = json["numberOfPages"] as! Int
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    return pageNum
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hopsTableView.dequeueReusableCell(withIdentifier: "hopsCell", for: indexPath)
        let text: String!
        
        text = self.fetchedHops[indexPath.row].name

        cell.textLabel?.text = text

        // Configure the cell...

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
