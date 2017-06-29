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
    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var breweryDescriptionLabel: UILabel!
    @IBOutlet weak var breweryWebsiteLabel: UILabel!
    @IBOutlet weak var breweryImageView: UIImageView!
    
    var breweryId: String = ""
    var breweryName: String = ""
    var breweryWebsite: String = ""
    var breweryDescription: String = ""
    var breweryImagePath: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.breweryDescriptionLabel.text = breweryDescription
        self.breweryWebsiteLabel.text = breweryWebsite
        
        let breweryImageUrl = URL(string: breweryImagePath)
        if breweryImageUrl != nil {
            let data = try? Data(contentsOf: breweryImageUrl!)
            if let imageData = data {
                self.breweryImageView.image = UIImage(data: imageData)
            }
        } else {
            self.breweryNameLabel.text = breweryName
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
