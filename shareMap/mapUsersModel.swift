//
//  mapUsersModel.swift
//  shareMap
//
//  Created by Likai Yan on 4/19/17.
//  Copyright © 2017 Likai Yan. All rights reserved.
//

import Foundation
import MapKit
class mapUser{
    // this class identifies the user's locaiton, and attempt to generate 
    // a range that displays other users around this user.

    // TODO: add database access!
    init(){
        // TODO: replace with initialized the database!
        
    }
    
    func lookAround()->[MKPointAnnotation]{
        return [MKPointAnnotation]();
    }
    
}
