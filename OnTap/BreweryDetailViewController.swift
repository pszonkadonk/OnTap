//
//  BreweryDetailViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/24/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit

class BreweryDetailViewController: UIViewController {

    @IBOutlet weak var breweryDetailView: UIView!
    @IBOutlet weak var breweryIdLabel: UILabel!
    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var breweryDescriptionLabel: UILabel!
    
    var breweryId: String = ""
    var breweryName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        parseBrewery(breweryId: breweryId)
    }
    
    
    
    func parseBrewery(breweryId: String) {
        let endpoint  = "http://api.brewerydb.com/v2/brewery/\(breweryId)/?key=6ac28fb2b6b8ea4081184e492e5462d8"
        print("This is endpoint")
        print(endpoint)
        guard let url = URL(string: endpoint)
            else {return}
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {(data, response, error) in
            
        guard let data = data else {
            print(error)
            return
        }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                    print("This is not a dictionary")
                    return
                }
                let breweryData: [String:Any] = json["data"] as! [String : Any]
                if (breweryData["id"] != nil) {
                    self.breweryIdLabel.text = breweryData["id"] as? String
                }
                if(breweryData["name"] != nil) {
                    self.breweryNameLabel.text = breweryData["name"] as? String
                }
                if(breweryData["description"] != nil) {
                    self.breweryDescriptionLabel.text = breweryData["description"] as? String
                }
                print(self.breweryIdLabel.text!)
                print(self.breweryNameLabel.text!)
                print(self.breweryDescriptionLabel.text!)
            } catch {
                print(error)
            }
        }
        task.resume()
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
