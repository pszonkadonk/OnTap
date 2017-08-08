//
//  UserAuthenticationViewController.swift
//  OnTap
//
//  Created by Michael Pszonka on 8/5/17.
//  Copyright © 2017 Michael Pszonka. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserAuthenticationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var dbRef: DatabaseReference? //database reference for users
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            actionButton.setTitle("Log In", for: .normal)
        case 1:
            actionButton.setTitle("Sign Up", for: .normal)
        default:
            break
        }

    }
    

    
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
                            self.alertUser(title: "Error Logging In", message: logError)
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
                        
                        var newUser: User = User(email: (user?.email)!)
                        
                        self.dbRef = Database.database().reference()
                        self.dbRef?.child("user").child((user?.uid)!).setValue(newUser.mutateUserObject())
                        
                        self.performSegue(withIdentifier: "mainMenuSegue", sender: self)
                    }
                    else { //failed to sign up user
                        // print out error,
                        if let logError = error?.localizedDescription {
                            self.alertUser(title: "Error Signing Up", message: logError)
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
    
    
    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
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
