//
//  BeerDetailViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 7/1/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    var targetBeer: Beer = Beer()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("ID \(targetBeer.id)")
        print("NAME \(targetBeer.name)")
        print("DESCRIPTION \(targetBeer.description)")
        print("ORGANIC \(targetBeer.isOrganic)")
        print("ABV \(targetBeer.abv)")
        print("STYLE \(targetBeer.style)")
        print("STYLE ID \(targetBeer.styleId)")
        print("ImagePath \(targetBeer.imagePath)")
    
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
