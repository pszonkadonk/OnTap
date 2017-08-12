//
//  GuildTableViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/4/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import Alamofire

class GuildListTableViewController: UITableViewController {
    
    @IBOutlet weak var guildListTableView: UITableView!
    
    
    var fetchedGuilds = [Guild]()
    var guildPageNumber: Int = 1
    
    
    override func viewDidLoad() {
        
        guildListTableView.dataSource = self
        guildListTableView.delegate = self
        fetchGuilds()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedGuilds.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guildCell", for: indexPath)
        
        let text: String!
        
        text = self.fetchedGuilds[indexPath.row].name
        
        cell.textLabel?.text = text
        
        return cell
    }
    
    func fetchGuilds(page:Int=1) {
        Alamofire.request("http://api.brewerydb.com/v2/guilds/?key=6ac28fb2b6b8ea4081184e492e5462d8&p=\(self.guildPageNumber)").responseJSON { response in
            if let json = response.result.value as? [String:Any] {
                if let guilds = json["data"] as? [[String:Any]] {
                    for guild in guilds {
                        let newGuild = Guild()
                        if let guildId = guild["id"] as? String {
                            newGuild.id = guildId
                        }
                                
                        if let guildName = guild["name"] as? String {
                            newGuild.name = guildName
                        }
                                
                        if let guildDescription = guild["description"] as? String {
                            newGuild.description = guildDescription
                        }
                        if let guildWebsite = guild["website"] as? String {
                            newGuild.website = guildWebsite
                        }
                        if let guildImages = guild["images"] as? [String:String] {
                            let guildImagePath = guildImages["medium"]
                            newGuild.imageUrl = guildImagePath!
                        }
                        self.fetchedGuilds.append(newGuild)
                    }
                }
            self.guildListTableView.reloadData()
            self.guildPageNumber += 1
            }
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var isLoadingNewData: Bool = false
        
        if scrollView == guildListTableView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                if !isLoadingNewData {
                    isLoadingNewData = true
                    fetchGuilds()
                }
            }
        }
    }

    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "guildDetailSegue",
            let destination = segue.destination as? GuildDetailViewController,
            let guildIndex = self.guildListTableView.indexPathForSelectedRow?.row
        {
            destination.guildId = self.fetchedGuilds[guildIndex].id
            destination.guildName = self.fetchedGuilds[guildIndex].name
            destination.guildDescription = self.fetchedGuilds[guildIndex].description
            destination.guildWebsite = self.fetchedGuilds[guildIndex].website
            destination.guildImagePath = self.fetchedGuilds[guildIndex].imageUrl
        }
     }
}
