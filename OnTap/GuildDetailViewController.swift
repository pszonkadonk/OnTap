//
//  GuildDetailViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/4/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit

class GuildDetailViewController: UIViewController {
    
    
    @IBOutlet weak var guildImageView: UIImageView!
    @IBOutlet weak var guildNameLabel: UILabel!
    @IBOutlet weak var guildDescriptionLabel: UILabel!
    @IBOutlet weak var guildWebsiteLabel: UILabel!
    
    var guildId: String = ""
    var guildName: String = ""
    var guildWebsite: String = ""
    var guildDescription: String = ""
    var guildImagePath: String = ""

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.guildDescriptionLabel.text = guildDescription
        self.guildWebsiteLabel.text = guildWebsite
        
        let guildImageUrl = URL(string: guildImagePath)
        if guildImageUrl != nil {
            let data = try? Data(contentsOf: guildImageUrl!)
            if let imageData = data {
                self.guildImageView.image = UIImage(data: imageData)
            }
        } else {
            self.guildNameLabel.text = guildName
        }
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
