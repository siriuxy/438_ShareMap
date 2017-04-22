//
//  NotesCollectionViewController.swift
//  shareMap
//
//  Created by RoYzH on 4/20/17.
//  Copyright © 2017 Likai Yan. All rights reserved.
//

import UIKit
import SQLite

private let reuseIdentifier = "Cell"

class NotesCollectionViewController: UICollectionViewController {

    @IBOutlet var NotesCV: UICollectionView!
    
    
    var currentUser = "currentUser"
    
    var noteNumber = 0  //currentUser's notes
    
    var noteTitle : [Notes] = []
    
    static var sharedInstance = DBUtil()
    var db:Connection?
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let notes = Table("Note")
    let noteId = Expression<Int64>("noteId")
    let userForNote = Expression<String>("user")
    let text = Expression<String>("text")
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let svc = segue.destination as! DetailsViewController
        let buttonSender = sender as! UIButton
        let index = buttonSender.tag
        svc.noteDetail = noteTitle[index]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        noteTitle.removeAll()
        do{
            db = try Connection("\(path)/shareMap.sqlite3")
            let query = notes.select(noteId,text)
                .filter(userForNote == currentUser)
            
            let all = Array(try (db?.prepare(query))!)
            
            noteNumber = all.count
            
            for item in all{
                // Get Note from Data Base
                let noteID = String(item[noteId])
                let noteText = String(item[text])
                noteTitle.append(Notes(noteID: noteID, text: noteText!, userName: "UserName", rating: "3", date: "April 19, 2017", time: "11:45 PM", image: #imageLiteral(resourceName: "Image")))
            }
            //            for note in try db?.prepare(note.filter(userForNoteId == 1)!)! {
            //                print("===========================id: \(note[noteId])")
            //                // id: 1, email: alice@mac.com
            //            }
        }
        catch{
            print(error)
        }
        NotesCV.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return noteTitle.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCell
    
        // Configure the cell
        let btnImage = noteTitle[indexPath.row].image
        cell.imageButton.setBackgroundImage(btnImage, for: UIControlState.normal)
        cell.imageButton.tag = indexPath.row
        cell.userName.text = noteTitle[indexPath.row].userName
        
        return cell
    }

    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
