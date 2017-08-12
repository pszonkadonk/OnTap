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
        
        guildNameLabel.textColor = UIColor.flatWhite
        guildNameLabel.textAlignment = NSTextAlignment.center
        guildDescriptionLabel.textColor = UIColor.flatWhite
        guildDescriptionLabel.textAlignment = NSTextAlignment.center
        guildWebsiteLabel.textColor = UIColor.flatWhite
        guildWebsiteLabel.textAlignment = NSTextAlignment.center

        
        
        super.viewDidLoad()
        
        self.guildDescriptionLabel.text = guildDescription
        self.guildWebsiteLabel.text = guildWebsite
        
        let guildImageUrl = URL(string: guildImagePath)
        if guildImageUrl != nil {
            let data = try? Data(contentsOf: guildImageUrl!)
            if let imageData = data {
                self.guildImageView.image = UIImage(data: imageData)
                guildImageView.layer.borderWidth = 1.0
                guildImageView.layer.borderColor = UIColor.black.cgColor
            }
        } else {
            self.guildNameLabel.text = guildName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
