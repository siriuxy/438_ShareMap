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
    
    func lookAround(location:CLLocationCoordinate2D)->[MKPointAnnotation]{
        // sample data, replce with data returned from sqlite
        let annotation1 = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2DMake(38.63779096,-90.3429794)
        annotation1.coordinate = coordinate;
        annotation1.title = "title1"
        annotation1.subtitle = "subtitle"
        
        let annotation2 = MKPointAnnotation()
        let coordinate2 = CLLocationCoordinate2DMake(38.63779096,-90.3343963)
        annotation2.coordinate = coordinate2;
        annotation2.title = "title2"
        annotation2.subtitle = "subtitle"
        
        // select close points.
        var locationArr = [annotation1, annotation2];
        var returnAnno = [MKPointAnnotation]();
        let curr = CLLocation(latitude: location.latitude, longitude: location.longitude);
        
        for loc in locationArr {
            if curr.distance(from: CLLocation(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)) < 5000 {
                returnAnno.append(loc);
            }
        }
        return returnAnno;
        
    }
    
    
}

//  http://stackoverflow.com/questions/11077425/finding-distance-between-cllocationcoordinate2d-points
extension CLLocation {
    // In meteres
    // ignores altitude dif.
    class func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distance(from: to);
    }
}
