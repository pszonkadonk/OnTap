//
//  HopListTableViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 7/25/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import Alamofire

class HopListTableViewController: UITableViewController {

    @IBOutlet weak var hopsTableView: UITableView!
    var fetchedHops = [Hops]()
    var hopsPageNumber: Int = 1
    
    
    override func viewDidLoad() {
        
        hopsTableView.dataSource = self
        hopsTableView.delegate = self
        fetchHops()
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
        return fetchedHops.count
    }
    
    func fetchHops(pageNumber: Int=1) {
        Alamofire.request("http://api.brewerydb.com/v2/hops/?key=6ac28fb2b6b8ea4081184e492e5462d8&p=\(self.hopsPageNumber)").responseJSON { response in
            
            if let json = response.result.value as? [String:Any] {
                if let hopsList = json["data"] as? [[String:Any]] {
                    for hops in hopsList {
                        let newHops = Hops()
                        if let id = hops["id"] as? Int {
                            newHops.id = id
                        }
                        
                        if let name = hops["name"] as? String {
                            newHops.name = name
                        }
                        
                        if let description = hops["description"] as? String {
                            newHops.description = description
                        }
                        if let alphaAcidMin = hops["alphaAcidMin"] as? Int {
                            newHops.alphaAcidMin = alphaAcidMin
                        }
                        
                        if let betaAcidMin = hops["betaAcidMin"] as? Int {
                            newHops.betaAcidMin = betaAcidMin
                        }
                        
                        if let betaAcidMax = hops["betaAcidMax"] as? Int {
                            newHops.betaAcidMax = betaAcidMax
                        }
                        
                        if let humuleneMin = hops["humuleneMin"] as? Int {
                            newHops.humuleneMin = humuleneMin
                        }
                        
                        if let humuleneMax = hops["humuleneMax"] as? Int {
                            newHops.humuleneMax = humuleneMax
                        }
                        
                        if let caryophylleneMin = hops["caryophylleneMin"] as? Int {
                            newHops.caryophylleneMin = caryophylleneMin
                        }
                        
                        if let caryophylleneMax = hops["caryophylleneMax"] as? Int {
                            newHops.caryophylleneMax = caryophylleneMax
                        }
                        
                        if let cohumuloneMin = hops["cohumuloneMin"] as? Int {
                            newHops.cohumuloneMin = cohumuloneMin
                        }
                        
                        if let cohumuloneMax = hops["cohumuloneMax"] as? Int {
                            newHops.cohumuloneMax = cohumuloneMax
                        }
                        
                        if let myrceneMin = hops["myrceneMin"] as? Int {
                            newHops.myrceneMin = myrceneMin
                        }
                        
                        if let myrceneMax = hops["myrceneMax"] as? Int {
                            newHops.myrceneMax = myrceneMax
                        }
                        
                        if let farneseneMin = hops["farneseneMin"] as? Int {
                            newHops.farneseneMin = farneseneMin
                        }
                        
                        if let farneseneMax = hops["farneseneMax"] as? Int {
                            newHops.farneseneMax = farneseneMax
                        }
                        print(newHops.name)
                        self.fetchedHops.append(newHops)
                    }
                    
                }
            }
            self.hopsTableView.reloadData()
            self.hopsPageNumber+=1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hopsTableView.dequeueReusableCell(withIdentifier: "hopsCell", for: indexPath)
        let text: String!
        
        text = self.fetchedHops[indexPath.row].name

        cell.textLabel?.text = text


        return cell
    }

override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    var isLoadingNewData: Bool = false
    
    if scrollView == hopsTableView {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
            if !isLoadingNewData {
                isLoadingNewData = true
                fetchHops()
            }
        }
    }
}



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "hopsDetailSegue",
            let destination = segue.destination as? HopsDetailViewController,
            let hopsIndex = self.hopsTableView.indexPathForSelectedRow?.row
        {
            destination.hopsNameLabelText = self.fetchedHops[hopsIndex].name
            destination.hopsDescriptionText = self.fetchedHops[hopsIndex].description
            destination.hopsAttributes.append(["Alpha Acid Min":self.fetchedHops[hopsIndex].alphaAcidMin])
            destination.hopsAttributes.append(["Beta Acid Min":self.fetchedHops[hopsIndex].betaAcidMin])
            destination.hopsAttributes.append(["Beta Acid Max":self.fetchedHops[hopsIndex].betaAcidMax])
            destination.hopsAttributes.append(["Humelene Min":self.fetchedHops[hopsIndex].humuleneMin])
            destination.hopsAttributes.append(["Humelene Max":self.fetchedHops[hopsIndex].humuleneMax])
            destination.hopsAttributes.append(["Caryophyllene Min":self.fetchedHops[hopsIndex].caryophylleneMin])
            destination.hopsAttributes.append(["Caryophyllene Max": self.fetchedHops[hopsIndex].caryophylleneMax])
            destination.hopsAttributes.append(["Cohumelene Min":self.fetchedHops[hopsIndex].cohumuloneMin])
            destination.hopsAttributes.append(["Cohumelene Max":self.fetchedHops[hopsIndex].cohumuloneMax])
            destination.hopsAttributes.append(["Myrcene Min":self.fetchedHops[hopsIndex].myrceneMin])
            destination.hopsAttributes.append(["Myrcene Max":self.fetchedHops[hopsIndex].myrceneMax])
            destination.hopsAttributes.append(["Farnesene Min":self.fetchedHops[hopsIndex].farneseneMin])
            destination.hopsAttributes.append(["Farnesene Max":self.fetchedHops[hopsIndex].farneseneMax])

        }
    }
    
}
