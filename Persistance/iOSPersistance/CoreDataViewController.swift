//
//  CoreDataViewController.swift
//  iOSPersistance
//
//  Created by Thomas Attermann on 27/05/2016.
//  Copyright © 2016 Thomas Attermann. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var managedContext: NSManagedObjectContext!
    
    // Array of People objects
    var people = [Person]() {
        didSet {
            tableViewPeople.reloadData()
        }
    }
    
    @IBOutlet weak var tableViewPeople: UITableView!

    // Button for saving Person object
    @IBAction func buttonAdd(sender: AnyObject) {
        
        // Show alert with two options
        let alertController = UIAlertController(title: "New Person", message: "Enter his/her name", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
        }
        
        // OK option
        let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
            let textField = alertController.textFields?.first
            self.save((textField?.text)!)
        }
        
        // Cancel option
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action) in
        }
        
        // Add alert actions to alertcontroller
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Core Data"
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        managedContext = appDelegate?.managedObjectContext

        tableViewPeople.delegate = self
        tableViewPeople.dataSource = self
        
        load()
    }
    
    // Method for saving
    func save(name: String) {
        let person = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: managedContext) as! Person
        person.name = name

        do {
            try managedContext.save()
            self.load()
        } catch let error as NSError {
            print("Bug in saving \(error)")
        }
    }
    
    // Method for loading
    func load() {
        let request = NSFetchRequest(entityName: "Person")
        
        do {
            let results = try managedContext.executeFetchRequest(request)
            self.people = results as! [Person]
        } catch {
            print("error in loading \(error)")
        }
    }
    
    // Required delegate methods ------------------------------------------------------
    
    // Numer of columns in tableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows in tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    // Set content for each cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("peopleCell", forIndexPath: indexPath)
        cell.textLabel?.text = people[indexPath.row].name
        return cell
    }



}
