//
//  Detailed.swift
//  shareMap
//
//  Created by Labuser on 4/10/17.
//  Copyright © 2017 Likai Yan. All rights reserved.
//

import UIKit

class Detailed: UIViewController {
    
    @IBOutlet weak var userIconImg: UIImageView!
    
    @IBOutlet weak var postImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // setup default post image and user image
        userIconImg.image = #imageLiteral(resourceName: "francis");
        postImage.image = #imageLiteral(resourceName: "348s");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
