//
//  BreweryDetailViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/24/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit

class BreweryDetailViewController: UIViewController {

    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var breweryIdLabel: UILabel!
    @IBOutlet weak var breweryDetailView: UIView!
    @IBOutlet weak var breweryWebsiteLabel: UILabel!

    var breweryDetail: [String:Any] = [:]
    var breweryName: String = ""
    var breweryId: String = ""
    var breweryWebsite: String = ""
    var breweryData: [String:Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.breweryDetail = parseBrewery(breweryId: self.breweryId)
    }
    
    
    
    func parseBrewery(breweryId: String) -> [String:Any] {
        let brewery:[String:Any] = [:]
        guard let url = URL(string: "http://api.brewerydb.com/v2/brewery/\(breweryId)/?key=6ac28fb2b6b8ea4081184e492e5462d8" )
            else {return brewery}
        
        let session = URLSession.shared
        session.dataTask(with: url) {(data, response, error) in
            
        if let data = data {
            print(data)
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    let brewery = json["data"] as? [String:Any]
                }
            } catch {
                print(error)
            }
        }
    }.resume()
        return brewery
}
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.breweryIdLabel.text = breweryId
        self.breweryNameLabel.text = breweryName
        self.breweryWebsiteLabel.text = breweryWebsite
//        print(self.breweryDetail)
//        self.breweryWebsiteLabel.text = self.breweryDetail["website"] as! String
//        self.breweryWebsiteLabel.text = self.breweryDetail["website"] as! String
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
