//
//  DBUtil.swift
//  shareMap
//
//  Created by enowang on 4/17/17.
//  Copyright © 2017 Likai Yan. All rights reserved.
//

import Foundation
import SQLite

class DBUtil{
    //reference:https://github.com/stephencelis/SQLite.swift

    
    static var sharedInstance = DBUtil()
    var db:Connection?
    
    
    // create the User table
    let users = Table("User")
    let userName = Expression<String?>("name")
    let userPassword = Expression<String>("password")
    let userProfile = Expression<String>("profile")  //TODO: modify the data format
    
    //create the Note table
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
    
    //create the Location table
    let location = Table("Location")
    let locationId = Expression<Int64>("locationId")
    let longitude = Expression<String?>("longitude")
    let latitude = Expression<String>("latitude")
    
    
    
    
    init(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print("------------------------path:"+path)
        
        do{
            db = try Connection("\(path)/shareMap.sqlite3")
            
            //initialize three tables in the database
            try db?.run(users.create(ifNotExists: true) { t in
                t.column(userName, unique: true)
                t.column(userPassword)
                t.column(userProfile)
            })
            
            try db?.run(notes.create(ifNotExists: true) { t in
                t.column(noteId,primaryKey: .autoincrement)
                t.column(userForNote)
                t.column(locationIdForNote)
                t.column(notePicure)
                t.column(text)
                t.column(date)
                t.column(rateForLocation)
                t.column(tag)
                t.column(isPrivate)
                
            })
            
            try db?.run(location.create(ifNotExists: true) { t in
                t.column(locationId, primaryKey: .autoincrement)
                t.column(longitude)
                t.column(latitude)
                
            })

//            try db?.run(users.insert(userId <- 123, userName <- "Alice", userPassword <- "123", userProfile <- "jph"))

//            for user in try db!.prepare(users) {
//                print("----------------------id: \(user[userId]), name: \(user[userName])")
//            }           
        }
        catch{
            print(error)
        }
        
    
    }
    
    func getById(){
    }
}
