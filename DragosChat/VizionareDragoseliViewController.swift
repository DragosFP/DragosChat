//
//  VizionareDragoseliViewController.swift
//  DragosChat
//
//  Created by Dragos Florin on 12/17/16.
//  Copyright © 2016 Dragos Florin. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class VizionareDragoseliViewController: UIViewController {

    @IBOutlet weak var imagineDragoseli: UIImageView!
    @IBOutlet weak var descriereDragoseli: UILabel!
    
    var dragoselile = Dragosel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriereDragoseli.text = dragoselile.descriere
        imagineDragoseli.sd_setImage(with: URL(string: dragoselile.imageURL))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("user").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(dragoselile.key).removeValue()
        
        FIRStorage.storage().reference().child("vederi").child("\(dragoselile.uuid).jpg").delete { (error) in
            print("Am sters poza")
        }
    }

} 
 
