//
//  MeController.swift
//  shareMap
//
//  Created by Labuser on 4/10/17.
//  Copyright © 2017 Likai Yan. All rights reserved.
//
import UIKit
import SQLite

class MeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var currentUser = "currentUser"
    
    var noteNumber = 0  //currentUser's notes
    
    var noteTitle : [String] = []
    
    static var sharedInstance = DBUtil()
    var db:Connection?
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let notes = Table("Note")
    let noteId = Expression<Int64>("noteId")
    let userForNote = Expression<String>("user")
    let text = Expression<String>("text")

    
    
    
    @IBOutlet weak var tableView: UITableView!
    var theData: [String] = []
    
    
    private func setupTableView() {
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            theData.remove(at: indexPath.row)
            var array=UserDefaults.standard.stringArray(forKey: "movieKey") ?? [String]()
            array.remove(at: indexPath.row)
            UserDefaults.standard.set(array,forKey:"movieKey")
            tableView.reloadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel!.text = noteTitle[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteNumber
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1{
            let detailedView = Detailed();
            self.navigationController?.pushViewController(detailedView, animated: true);
        }
    }
    
    @IBAction func addNote(_ sender: UIButton) {
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        do{
            db = try Connection("\(path)/shareMap.sqlite3")
            let query = notes.select(noteId,text)
                .filter(userForNote == currentUser)

            let all = Array(try (db?.prepare(query))!)
            
            noteNumber = all.count
            var title = " "
            for item in all{
                title = String(item[noteId]) + " " + String(item[text.substring(5)])
                noteTitle.append(title)
                
            }
            
//            for note in try db?.prepare(note.filter(userForNoteId == 1)!)! {
//                print("===========================id: \(note[noteId])")
//                // id: 1, email: alice@mac.com
//            }
        }
        catch{
            print(error)
        }
       
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
