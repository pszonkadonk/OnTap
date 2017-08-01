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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hopsNameLabel.text = hopsNameLabelText
        self.hopsDescriptionLabel.text = hopsDescriptionText
        
//        var foo = Array(hopsAttributes[0].values)
        
        
//        print(foo[0])
        // Do any additional setup after loading the view.
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
        
        
        // Configure the cell...
        
        return cell
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
