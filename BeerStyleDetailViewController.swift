//
//  BeerStyleDetailViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/1/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit

class BeerStyleDetailViewController: UIViewController {
    
    @IBOutlet weak var beerStyleNameLabel: UILabel!
    @IBOutlet weak var beerStyleDescriptionLabel: UILabel!
    
    var beerStyleName: String = ""
    var beerStyleDescription: String = ""

    override func viewDidLoad() {
        
        super.viewDidLoad()

        print(beerStyleName)
        print(beerStyleDescription)
        beerStyleNameLabel.text = beerStyleName
        beerStyleDescriptionLabel.text = beerStyleDescription
        

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
