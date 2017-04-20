//
//  AddNoteViewController.swift
//  shareMap
//
//  Created by RoYzH on 4/11/17.
//  Copyright © 2017 Likai Yan. All rights reserved.
//

import UIKit
import SQLite

class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var Text: UITextView!
    
    var dataBack : [String] = ["2017-04-19","3"]
    
    var currentUser = "currentUser"
    
    var currentLocation = 12
    
    static var sharedInstance = DBUtil()
    var db:Connection?
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    let notes = Table("Note")
    let noteId = Expression<Int64>("noteId")
    let userForNote = Expression<String>("user")
    let locationIdForNote = Expression<Int64>("locationId")
    let notePicure = Expression<String>("picture") //TODO: modify the data format
    
    let text = Expression<String>("text")
    let date = Expression<String>("date")
    let rateForLocation = Expression<String>("rate")
    let tag = Expression<String>("tag")
    let isPrivate = Expression<Bool>("isPrivate")
    
    @IBOutlet weak var myImageView: UIImageView!

    @IBAction func importImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else {
                print("Camera not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)

    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        myImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func more(_ sender: Any) {
        let more = MoreViewController(nibName: "MoreViewController", bundle: nil)
        
        navigationController?.pushViewController(more, animated: true)
        
    }

    

    @IBAction func publishNote(_ sender: UIButton) {
        do{
            db = try Connection("\(path)/shareMap.sqlite3")
            
            //let id =
            try db?.run(notes.insert(userForNote <- currentUser,locationIdForNote <- Int64(currentLocation), notePicure <- "jph",text <- Text.text,date <- dataBack[0],rateForLocation <- dataBack[1],tag <- "food",isPrivate <- false))

           
        }
        catch{
            print(error)
        }
        
        
        
        
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
