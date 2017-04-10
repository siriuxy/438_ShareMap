//
//  mapViewController.swift
//  shareMap
//
//  Created by Likai Yan on 4/7/17.
//  Copyright © 2017 Likai Yan. All rights reserved.
//

import Foundation

import UIKit
import CoreLocation
import MapKit
import FirebaseAuth

// TODO: programmatically connect map to navigation controller to collectionview controller, which leads to detailed view of an entry.

class mapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager();
    var coord = CLLocationCoordinate2D();
    // let userLocation = CLLocation();
    
    @IBAction func LogOutButton(_ sender: UIButton) {
        do {
            try FIRAuth.auth()?.signOut()
            self.presentHomePage()
        }
        catch {
            print("There was a problem logging out!")
        }
    }
    
    func presentHomePage () {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeVC: WelcomeViewController = storyboard.instantiateViewController(withIdentifier: "StartPage") as! WelcomeViewController
        self.present(welcomeVC, animated: true, completion: nil)
    }
    
    @IBAction func whereAmI(_ sender: UIButton) {
        mapView.setCenter(coord, animated: true)
        // TODO: use setRegion to animate!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        mapView.delegate = self
        mapView.showsUserLocation = false
        mapView.mapType = MKMapType(rawValue: 0)! // case standard
        mapView.userTrackingMode = MKUserTrackingMode(rawValue: 1)! // case follow

        locationManager.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // print(CLLocationManager.locationServicesEnabled())

        /*
        var anView:MKAnnotationView = MKAnnotationView()
        anView.annotation = myHomePin
        anView.image = #imageLiteral(resourceName: "first")
        anView.canShowCallout = true
        anView.isEnabled = true
 */

    }
    
    // http://stackoverflow.com/questions/24467408/swift-add-mkannotationview-to-mkmapview
    // update current location
    // record the last MKAnnotation, and delete it upon refreshing!
    
    var lastAnnotation:MKAnnotation?
    var delayConter = 3;
    // var decodedAddr = ""
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // we know there is at least 1 element in the array!
        // userLocation = locations.last!
        // lat="38.63779096" lon="-90.3429794">
        coord = locations.last!.coordinate;

        if lastAnnotation != nil{
            var myHomePin = MKPointAnnotation();
            myHomePin.coordinate = coord;
            myHomePin.title = lastAnnotation?.title!;
            myHomePin.subtitle = lastAnnotation?.subtitle!;
            mapView.addAnnotation(myHomePin)
            mapView.selectAnnotation(myHomePin, animated: false);
            mapView.removeAnnotation(lastAnnotation!)
            lastAnnotation = myHomePin;
        }
        let coordDisplay = "\(coord.latitude),\(coord.longitude)"

        // http://stackoverflow.com/questions/27495328/reverse-geocode-location-in-swift
        let geoCoder = CLGeocoder()
        
        // TODO: add distance change -> Reverse Geo query
        // async trigger MKAnno re-rendering
        if delayConter % 5 == 0 {
        geoCoder.reverseGeocodeLocation(locations.last!, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            // print (placemarks);
            if (placemarks != nil) {
                print("p is not nil")
                for p in placemarks! {
                    // iotDataManager.publishString(p.compactAddress!, onTopic: "address", qoS:.messageDeliveryAttemptedAtMostOnce)
                    if self.lastAnnotation != nil{
                        self.mapView.removeAnnotation(self.lastAnnotation!);
                    }
                    print("decoded:\(p.compactAddress!)");
                    let myHome = locations.last!
                    var myHomePin = MKPointAnnotation()
                    myHomePin.subtitle = p.compactAddress! // to be changed to your reversed GeoCode
                    print(p);
                    myHomePin.coordinate = myHome.coordinate;
                    myHomePin.title = "Your location"
                    self.mapView.addAnnotation(myHomePin)
                    // let MKPAArr = [myHomePin]
                    self.mapView.selectAnnotation(myHomePin, animated: false)
                    self.lastAnnotation = myHomePin;
                }
            }
            if (placemarks?.count)! > 0 {
                print(placemarks![0].locality ?? "failed to fetch")
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        }
        delayConter += 1;


    
    }
    
    // this sets the MKAV to display MKA
    // http://stackoverflow.com/questions/24467408/swift-add-mkannotationview-to-mkmapview
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            // anView?.image = #imageLiteral(resourceName: "first")
            // perhaps use "UIImage" average color as a preview.
            // radius to define visible area. Freshness (updated time) to define the size.
            anView?.canShowCallout = true
            // whole bubble as a clickable
            //https://github.com/koogawa/MKMapViewSample/blob/master/MKMapViewSample/ImageViewController.swift
            let rightButton: AnyObject! = UIButton(type: UIButtonType.detailDisclosure)
            anView?.rightCalloutAccessoryView = rightButton as? UIView
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView?.annotation = annotation
        }
        
        return anView

    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView{
            performSegue(withIdentifier: "collectionViewController", sender: self);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


//https://cocoacasts.com/forward-and-reverse-geocoding-with-clgeocoder-part-2/
extension CLPlacemark {
    
    var compactAddress: String? {
        if let name = name {
            // var result = name
            var result = ""
            if let street = thoroughfare {
                result += "\(street)"
            }
            
            if let city = locality {
                result += ", \(city)"
            }
            /*
            if let country = country {
                result += ", \(country)"
            }
            */
            return result
        }
        
        return nil
    }
    
}

