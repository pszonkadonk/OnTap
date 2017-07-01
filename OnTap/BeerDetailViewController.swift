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
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerAbvLabel: UILabel!
    @IBOutlet weak var beerStyleLabel: UILabel!
    @IBOutlet weak var beerIsOrganicLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        print("ID \(targetBeer.id)")
        print("NAME \(targetBeer.name)")
        print("DESCRIPTION \(targetBeer.description)")
        print("ORGANIC \(targetBeer.isOrganic)")
        print("ABV \(targetBeer.abv)")
        print("STYLE \(targetBeer.style)")
        print("STYLE ID \(targetBeer.styleId)")
        print("ImagePath \(targetBeer.imagePath)")
        
        
        self.beerNameLabel.text = targetBeer.name
        self.beerAbvLabel.text = targetBeer.abv
        self.beerStyleLabel.text = targetBeer.style
        self.beerIsOrganicLabel.text = targetBeer.isOrganic
        self.beerDescriptionLabel.text = targetBeer.description
        
        if(targetBeer.imagePath != "") {
            let beerImageUrl = URL(string: targetBeer.imagePath)
            let data = try? Data(contentsOf: beerImageUrl!)
            if let imageData = data {
                self.beerImageView.image = UIImage(data: imageData)
            }
        } else {
            print("there was no image")
            let filePath = Bundle.main.path(forResource: "placeholder", ofType: "png")
            print(filePath)
            self.beerImageView.image = UIImage(contentsOfFile: filePath!)
        }

        super.viewDidLoad()
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
