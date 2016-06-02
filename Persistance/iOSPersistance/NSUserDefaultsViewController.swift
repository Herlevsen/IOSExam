//
//  NSUserDefaultsViewController.swift
//  iOSPersistance
//
//  Created by Thomas Attermann on 27/05/2016.
//  Copyright © 2016 Thomas Attermann. All rights reserved.
//

import UIKit

class NSUserDefaultsViewController: UIViewController {

    // Textfield for entering word to save
    @IBOutlet weak var textfieldWord: UITextField!
    
    // Button to save entered word
    @IBAction func buttonSave(sender: AnyObject) {
        
        // Utilize NSUserDefaults to persistand word assosciated with key
        NSUserDefaults.standardUserDefaults().setObject(textfieldWord.text, forKey: "word")
        textfieldWord.text = ""
        textfieldWord.placeholder = "Saved word"
    }
    
    // Label to display saved word
    @IBOutlet weak var labelWord: UILabel!
    
    // Button to get saved word
    @IBAction func buttonFetch(sender: AnyObject) {
        let savedWord = String(NSUserDefaults.standardUserDefaults().objectForKey("word")!)
        labelWord.text = "Saved word: \(savedWord)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NSUserDefaults"
    }

}
