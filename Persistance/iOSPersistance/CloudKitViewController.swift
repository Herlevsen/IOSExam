//
//  CloudKitViewController.swift
//  iOSPersistance
//
//  Created by Thomas Attermann on 27/05/2016.
//  Copyright © 2016 Thomas Attermann. All rights reserved.
//

import UIKit
import CloudKit

class CloudKitViewController: UIViewController {
    
    var db:CKDatabase?
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var textfieldUsername: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBAction func buttonLogin(sender: AnyObject) {
        
        getUser(self.textfieldUsername.text!, password: self.textfieldPassword.text!)
        
        textfieldUsername.text = ""
        textfieldPassword.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CloudKit"
        
        // Initialiser databse
        db = CKContainer.defaultContainer().publicCloudDatabase

        //insertUser("Thomas", password: "secret")
        //getUser("John", password: "123")
    }
    
    // Get method for record with parameters
    func getUser(username:String, password:String) {
        // Condition for query
        let predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        // Define query and specify condition
        let query = CKQuery(recordType: "MyUsers", predicate: predicate)
        
        db?.performQuery(query, inZoneWithID: nil, completionHandler: { (records:[CKRecord]?, error:NSError?) -> Void in
            // If user interface is touched use dispatch_async
           dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // If no errors
                if error == nil {
                    // No users
                    if records?.count == 0 {
                        self.testLabel.text = "No user with entered credentials"
                    }
                    else {
                        // Loop through records
                        for record in records! {
                            // Print name ans password to
                            let usr = record.objectForKey("username") as! String
                            let pw = record.objectForKey("password") as! String
                            self.testLabel.text = "Welcome user: \(usr) - password: \(pw)"

                        }
                    }
                } else {
                    print("Bad request asking for \(username)")
                }
                
            })
        })
        
    }
    
    // Gem record
    func insertUser(username : String, password : String) {
        let record = CKRecord(recordType: "MyUsers")
        record.setObject(username, forKey: "username")
        record.setObject(password, forKey: "password")
        db?.saveRecord(record, completionHandler: {(record:CKRecord?, error:NSError?) ->
            Void in
            if error == nil {
                print("Save successfull")
            } else {
                print(error)

                print("Not successfull")
            }
        })
        
    }






}
