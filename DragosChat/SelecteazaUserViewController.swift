//
//  SelecteazaUserViewController.swift
//  DragosChat
//
//  Created by Dragos Florin on 12/9/16.
//  Copyright © 2016 Dragos Florin. All rights reserved.
//

import UIKit
import Firebase

class SelecteazaUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var utilizatori : [Utilizator] = []
    var imageURL = ""
    var descriere = ""
    var uuid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        FIRDatabase.database().reference().child("user").observe(FIRDataEventType.childAdded, with: {(snapshot) in
        print(snapshot)
            let user = Utilizator()
            user.email = (snapshot.value as! NSDictionary)["email"] as! String
            user.uid = snapshot.key
        
            self.utilizatori.append(user)
            
            self.tableView.reloadData()
    })
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return utilizatori.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let user = utilizatori[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = utilizatori[indexPath.row]
        let snap = ["from":FIRAuth.auth()!.currentUser!.email!, "descriere": descriere, "imageURL":imageURL, "uuid":uuid]
        
        FIRDatabase.database().reference().child("user").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        navigationController!.popToRootViewController(animated: true)   //Ne trimite la primul viewcontroller
         
    }
   
}
