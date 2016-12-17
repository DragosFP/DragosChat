//
//  SignInViewController.swift
//  DragosChat
//
//  Created by Dragos Florin on 11/6/16.
//  Copyright © 2016 Dragos Florin. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var campParola: UITextField!
    @IBOutlet weak var campEmail: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func butonAcces(_ sender: AnyObject) {
        
    FIRAuth.auth()?.signIn(withEmail: campEmail.text!, password: campParola.text!, completion: { (user, error) in
        print("Am incercat sa ne logam")
        if error != nil {
            print("Avem o erore\(error)")
            
            FIRAuth.auth()?.createUser(withEmail: self.campEmail.text!, password: self.campParola.text!, completion: { (user, error) in
                print("Am incercat sa cream un user")
                if error != nil {
                    print("Avem o eroare 2")
                } else {
                    print("Creare user reusita")
                    
                FIRDatabase.database().reference().child("user").child(user!.uid).child("email").setValue(user!.email!)
                    
                    self.performSegue(withIdentifier: "inregistrareSegue", sender: nil)
                }
            })
            
        } else {
            print("Inregistrare reusita")
            self.performSegue(withIdentifier: "inregistrareSegue", sender: nil)
        }
    })
        
    }
}

