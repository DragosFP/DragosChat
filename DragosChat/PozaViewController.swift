//
//  PozaViewController.swift
//  DragosChat
//
//  Created by Dragos Florin on 11/20/16.
//  Copyright © 2016 Dragos Florin. All rights reserved.
//

import UIKit
import Firebase

class PozaViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var butonUrmatorul: UIButton!
    @IBOutlet weak var campText: UITextField!
    @IBOutlet weak var imagine: UIImageView!
    
    var imagePiker = UIImagePickerController ()
    var uuid = NSUUID().uuidString
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        butonUrmatorul.isEnabled = false
        
        imagePiker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imaginea = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imagine.image = imaginea
        imagine.backgroundColor = UIColor.clear
        
        butonUrmatorul.isEnabled = true
        
        imagePiker.dismiss(animated: true, completion: nil)
        
    }
    

    @IBAction func cameraApasat(_ sender: AnyObject) {
        
        imagePiker.sourceType = .savedPhotosAlbum
        imagePiker.allowsEditing = false
        
        present(imagePiker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func urmatorulApasat(_ sender: AnyObject) {
        
        butonUrmatorul.isEnabled = false
        
        let FolderVederi = FIRStorage.storage().reference().child("vederi")
        
         /* let vedereData = UIImagePNGRepresentation(imagine.image!)! */ // Transforma imagine in data
        
        let vedereData = UIImageJPEGRepresentation(imagine.image!, 0.1)!
        
        
        
        FolderVederi.child("\(uuid).jpg").put(vedereData, metadata: nil) { (metadata, error) in
            print("Am incercat sa uplodam")
            if error != nil {
                print("Avem o eroare:\(error)")
                
            } else {
                print(metadata?.downloadURL()) // printeaza link-ul de download
                
                self.performSegue(withIdentifier: "adreseSegue", sender: metadata?.downloadURL()!.absoluteString)
            
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! SelecteazaUserViewController
        nextVC.imageURL = sender as! String
        nextVC.descriere = campText.text!
        nextVC.uuid = uuid
        
    }
    
    
    
}
