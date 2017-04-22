//
//  MoreViewController.swift
//  shareMap
//
//  Created by enowang on 4/18/17.
//  Copyright © 2017 Likai Yan. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var date: UIDatePicker!

    @IBOutlet weak var rate: CosmosView!
    
    @IBAction func PickDate(_ sender: UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "MMMM dd, YYYY"
        dataBack[0] = format.string(from: date.date)
        
        format.dateFormat = "hh:mm a"
        dataBack[1] = format.string(from: date.date)
    }
    
    //store the push back data: date and rate for the location
    var dataBack: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self

        // Do any additional setup after loading the view.
        let format = DateFormatter()
        format.dateFormat = "MMMM dd, YYYY"
        dataBack.append(format.string(from: date.date))
        
        format.dateFormat = "hh:mm a"
        dataBack.append(format.string(from: date.date))
        
        let rating = Int(rate.rating.rounded())
        dataBack.append(String(rating))
        
        print(dataBack[0])
        print(dataBack[1])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


extension MoreViewController {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let rating = Int(rate.rating.rounded())
        dataBack[2] = String(rating)
        (viewController as? AddNoteViewController)?.dataBack = dataBack
    }
}
