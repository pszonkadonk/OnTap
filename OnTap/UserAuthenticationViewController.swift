//
//  UserAuthenticationViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/5/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserAuthenticationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func action(_ sender: UIButton) {
        
        if(emailTextField.text != nil && passwordTextField.text != nil) {
            
            if(segmentControl.selectedSegmentIndex == 0) { // login selected
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user, error) in
                    if(user != nil) {
                        // successful login
                        self.performSegue(withIdentifier: "mainMenuSegue", sender: self)
                        
                    }
                    else {
                        // print out error, 
                        if let logError = error?.localizedDescription {
                            print(logError)
                        }
                        else {
                            print("Generic Error")
                        }
                    }
                })
                
                    
            }
            else {  // sign up user
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user, error) in
                 
                    if(user != nil) { //successfully signed up user
                        self.performSegue(withIdentifier: "mainMenuSegue", sender: self)
                    }
                    else { //failed to sign up user
                        // print out error,
                        if let logError = error?.localizedDescription {
                            print(logError)
                        }
                        else {
                            print("Generic Error")
                        }
                    }
                })
            }
        }
        
    }
    

    override func viewDidLoad() {
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
