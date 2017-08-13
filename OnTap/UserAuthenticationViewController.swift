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
import ChameleonFramework

class UserAuthenticationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var ontapHeaderLabel: UILabel!
    let strokeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName: UIColor.flatOrange,
        NSStrokeWidthAttributeName : -3.0,
        NSFontAttributeName : UIFont.boldSystemFont(ofSize: 47)
        ] as [String : Any]

    var dbRef: DatabaseReference? //database reference for users
    
    @IBOutlet weak var userAuthenticationView: UIView!
    
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
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSForegroundColorAttributeName: UIColor.flatWhite])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.flatWhite])
        emailTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderWidth = 1.0
        actionButton.layer.cornerRadius = 5
        actionButton.layer.borderWidth = 1
        segmentControl.layer.borderWidth = 1.0
        segmentControl.layer.borderColor = UIColor.black.cgColor
        
        ontapHeaderLabel.attributedText = NSMutableAttributedString(string: "Welcome To OnTap!", attributes: strokeTextAttributes)

        


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
    
    
}
