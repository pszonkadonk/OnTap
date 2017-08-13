//
//  BeerStyleDetailViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/1/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import ChameleonFramework

class BeerStyleDetailViewController: UIViewController {
    
    @IBOutlet weak var beerStyleNameLabel: UILabel!
    @IBOutlet weak var beerStyleDescriptionLabel: UILabel!
    let strokeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName: UIColor.flatOrange,
        NSStrokeWidthAttributeName : -3.0,
        NSFontAttributeName : UIFont.boldSystemFont(ofSize: 47)
        ] as [String : Any]

    
    var beerStyleName: String = ""
    var beerStyleDescription: String = ""

    override func viewDidLoad() {
        
        super.viewDidLoad()

        beerStyleNameLabel.text = beerStyleName
        beerStyleNameLabel.textColor = UIColor.flatWhite
        beerStyleNameLabel.textAlignment = NSTextAlignment.center
        beerStyleDescriptionLabel.textColor = UIColor.flatWhite
        beerStyleDescriptionLabel.textAlignment = NSTextAlignment.center
        
        if(beerStyleDescription == "") {
            beerStyleDescriptionLabel.text = "No Description Available"
        } else {
            beerStyleDescriptionLabel.text = beerStyleDescription
        }

        

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
