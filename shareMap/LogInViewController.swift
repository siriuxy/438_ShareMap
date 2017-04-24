//
//  LogInViewController.swift
//  UserLogin
//
//  Created by RoYzH on 4/9/17.
//  Copyright © 2017 RoYzH. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let fblogin: FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(fblogin)
            fblogin.center = self.view.center
            fblogin.readPermissions = ["public_profile", "email", "user_friends"]
            fblogin.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Facebook Delegate Methods
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                print("Successful Login!")
                self.presentLogin()
            }
            
        }
       
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
   
    
    @IBAction func LoginButton(_ sender: Any) {
        // No email input or password input
        if emailTextField.text == "" || passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter your email and password!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if let firebaseError = error {
                    
                    let alertController = UIAlertController(title: "Oops!", message: firebaseError.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                print("Successful Login!")
                self.presentLogin()
            })
        }
    }
    
    
    // Navigate to already login page
    func presentLogin () {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let TabBarVC: UITabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
        self.present(TabBarVC, animated: true, completion: nil)
    }
}
