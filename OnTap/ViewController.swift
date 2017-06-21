//
//  ViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 6/20/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var menuShowing: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func openMenu(_ sender: Any) {
        
        if(menuShowing) {
            leadingConstraint.constant = -161
            menuShowing = false
        } else {
            leadingConstraint.constant = 0
            menuShowing = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        
        
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

