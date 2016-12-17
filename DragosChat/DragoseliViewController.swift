//
//  DragoseliViewController.swift
//  DragosChat
//
//  Created by Dragos Florin on 11/19/16.
//  Copyright © 2016 Dragos Florin. All rights reserved.
//

import UIKit
import Firebase

class DragoseliViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var dragoseli : [Dragosel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        FIRDatabase.database().reference().child("user").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            let dragosel = Dragosel()
            dragosel.descriere = (snapshot.value as! NSDictionary)["descriere"] as! String
            dragosel.from = (snapshot.value as! NSDictionary)["from"] as! String
            dragosel.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            dragosel.key = (snapshot.key)
            dragosel.uuid = (snapshot.value as! NSDictionary)["uuid"] as! String
            
            self.dragoseli.append(dragosel)
            
            self.tableView.reloadData()
        })
        
        FIRDatabase.database().reference().child("user").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
            print(snapshot)
            
            var index=0
            for snap in self.dragoseli {
                if snap.key == (snapshot.key){
                    self.dragoseli.remove(at: index)
                    
                }
                index += 1
            }
            self.tableView.reloadData()
            
        })
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deconectareApasat(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dragoseli.count == 0 {
            return 1
        }else{
            return dragoseli.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if dragoseli.count == 0{
            
            cell.textLabel?.text = "Nu ai nici un Snap 😞"
             
        } else {
            let dragosel = dragoseli[indexPath.row]
            
            cell.textLabel?.text = dragosel.from
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        let dragosel = dragoseli[indexPath.row]
        
        performSegue(withIdentifier: "VizionareDragoseliSegue", sender: dragosel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "VizionareDragoseliSegue" {
        let nextVC = segue.destination as! VizionareDragoseliViewController
        nextVC.dragoselile = sender as! Dragosel
        }
    }

}
