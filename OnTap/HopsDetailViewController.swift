//
//  HopsDetailViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 7/26/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit //TODO add trable view for all other hops attributes within detail

class HopsDetailViewController: UIViewController {

    @IBOutlet weak var hopsNameLabel: UILabel!
    @IBOutlet weak var hopsDescriptionLabel: UILabel!
    
    var hopsNameLabelText: String = ""
    var hopsDescriptionText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hopsNameLabel.text = hopsNameLabelText
        self.hopsDescriptionLabel.text = hopsDescriptionText
        // Do any additional setup after loading the view.
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
