//
//  ViewController.swift
//  FacebookLogin
//
//  Created by Thomas Attermann on 31/05/2016.
//  Copyright © 2016 Thomas Attermann. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var image: UIImageView!
    
    let loginButton: FBSDKLoginButton = {(in2:String) -> FBSDKLoginButton in //clossure!!
        let button = FBSDKLoginButton()
        button.readPermissions = [in2]
        return button
    }("email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add login button
        view.addSubview(loginButton)
        loginButton.center = view.center
        
        // Set delegate
        loginButton.delegate = self
        
        // Check  if token is set - if set, print this information.
        if let _ = FBSDKAccessToken.currentAccessToken(){
            print("user is already logged in")
        }
    }
    
    // Method for getting profile information
    func getProfile(){
        let parameters = ["fields" : "email, first_name, last_name, picture"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) in
            if error != nil {
                print(error.debugDescription)
                print("error")
                return
            }
            
            // If there is a value for email --> extract and print.
            if let email = result["email"]as? String {
                print("email is \(email)")
            }
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as?
                NSDictionary, url = data["url"] as? String{
                print("URL is: \(url)")
                self.downloadImage(NSURL(string: url)!)
            }
            if let firstName = result["first_name"] as? String {
                print("Firstname is \(firstName)")
            }
            
            
        }
    }
    
    // Method for downloading image and setting in UIImageView
    func downloadImage(url:NSURL){
        NSURLSession.sharedSession().dataTaskWithURL(url){
            (data, response, error) in
            dispatch_async(dispatch_get_main_queue(),{
                if error == nil {
                    let fbimage = UIImage(data: data!)
                    self.image.image = fbimage
                }
            })
            }.resume()
    }
    
    // Method that calls getProfile() method and logs user in
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        getProfile()
        print("user logged in succesfully")
    }
    
    // Method that calls getProfile() method and logs user out
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user logged out succesfully")
        image.image = nil
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    
}

