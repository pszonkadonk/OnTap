//
//  HopsDetailViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 7/26/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit //TODO add trable view for all other hops attributes within detail

class HopsDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var hopsNameLabel: UILabel!
    @IBOutlet weak var hopsDescriptionLabel: UILabel!
    @IBOutlet weak var hopsStatsTableView: UITableView!
    
    
    var hopsNameLabelText: String = ""
    var hopsDescriptionText: String = ""
    var hopsAttributes = [[String:Int]]()
    
    let strokeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName: UIColor.flatOrange,
        NSStrokeWidthAttributeName : -3.0,
        NSFontAttributeName : UIFont.boldSystemFont(ofSize: 47)
        ] as [String : Any]

    
    override func viewDidLoad() {
        
        hopsDescriptionLabel.textColor = UIColor.flatWhite
        hopsDescriptionLabel.textAlignment = NSTextAlignment.center
        
        self.hopsNameLabel.text = hopsNameLabelText
        if(hopsDescriptionText == "") {
            self.hopsDescriptionLabel.text = "Not Description Available"
        } else {
            self.hopsDescriptionLabel.text = hopsDescriptionText
        }

        
        
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hopsStatsTableView.dequeueReusableCell(withIdentifier: "hopsStatsCell", for: indexPath)
        let text: String!
        
        var key = Array(self.hopsAttributes[indexPath.row].keys)[0]
        var value = Array(self.hopsAttributes[indexPath.row].values)[0]
        
        text = key + " : " + String(value)
        
        cell.textLabel?.text = text
        cell.backgroundColor = UIColor.flatSkyBlue
        cell.textLabel?.textColor = UIColor.flatWhite
        
        return cell
    }
}
