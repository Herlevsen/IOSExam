//
//  CoreDataRelationshipViewController.swift
//  iOSPersistance
//
//  Created by Thomas Attermann on 30/05/2016.
//  Copyright © 2016 Thomas Attermann. All rights reserved.
//

import UIKit
import CoreData

class CoreDataRelationshipViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var managedContext: NSManagedObjectContext!
    
    var continents:[Continent] = []
    var countries: [Country] = []

    @IBOutlet weak var pickerView: UIPickerView!
    
    var currentContinent:Continent? // Will be set every time a pickerWheel is changed.
    
    @IBAction func addContinentButton(sender: AnyObject) {
        presentAlertController("Continent")
    }
    
    @IBAction func addCountryButton(sender: AnyObject) {
        presentAlertController("Country")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Core Data Relationships"
        
        // Setting the viewcontroller to be the subscriber of the data source
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // Handles interaction with DB link
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        managedContext = appDelegate?.managedObjectContext
        load()
    }
    
    // Method for entering new country / continent
    func presentAlertController(type:String) {
        // UIAlertController
        let alertController = UIAlertController(title: type, message: "Enter new \(type)", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            
        }
        let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
            let textField = alertController.textFields?.first
            if type == "Continent" {
                self.saveContinent((textField?.text)!)
            }
            if type == "Country" {
                self.saveCountry((textField?.text)!)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action) in
            
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }

    
    // DELEDATE METHODS (PickerView) ---------------------------------------------------------------------
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            currentContinent = continents[row]
            load()
        }
        if component == 1 {
            print("You selected \(countries[row])")
        }
    }
    
    // Define number of wheels in picker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // Define number of rows in each component - get amount from continent / country array
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return continents.count
        }
        if component == 1 {
            return countries.count
        }
        
        return 0

    }
    
    // Define title for row - get from continent / country array
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return continents[row].name
        }
        if component == 1 {
            return countries[row].name
        }
        return "none"
    }
    
    // Core Data persistance methods ---------------------------------------------------------------------
    
    // Saving Continents
    func saveContinent(continentName: String) {
        let continent = NSEntityDescription.insertNewObjectForEntityForName("Continent", inManagedObjectContext: managedContext) as! Continent
        
        continent.name = continentName
        saveContext()
    }
    
    // Saving Countries
    func saveCountry(countryName: String) {
        if currentContinent != nil {
            let country = NSEntityDescription.insertNewObjectForEntityForName("Country", inManagedObjectContext: managedContext) as! Country
            country.name = countryName
            country.belongsTo = currentContinent
            saveContext()
        }
    }
    
    func saveContext() {
        
        do {
            try managedContext.save()
            self.load()
        } catch let error as NSError {
            print("Bug in saving \(error)")
        }
    }
    
    // Method for loading continents and countries
    func load() {
        
        // Define requests with entity names
        let continentRequest = NSFetchRequest(entityName: "Continent")
        let countryRequest = NSFetchRequest(entityName: "Country")
        
        do {
            let continentRequest = try managedContext.executeFetchRequest(continentRequest)
            
            continents = continentRequest as! [Continent]
            
            if currentContinent != nil {
                countryRequest.predicate = NSPredicate(format: "belongsTo.name = %@", (currentContinent?.name)!)
            }
            let countryResults = try managedContext.executeFetchRequest(countryRequest)
            
            countries = countryResults as! [Country]
            
            // Reload componenst
            pickerView.reloadAllComponents()
            
        } catch {
            print("error in loading \(error)")
        }
    }



}
