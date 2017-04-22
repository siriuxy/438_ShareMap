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

    @IBOutlet weak var Rate: UILabel!
    
    @IBAction func PickDate(_ sender: UIDatePicker) {
        
    }
    
    //store the push back data: date and rate for the location
    var dataBack: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self

        // Do any additional setup after loading the view.
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
        (viewController as? AddNoteViewController)?.dataBack = dataBack
    }
}
