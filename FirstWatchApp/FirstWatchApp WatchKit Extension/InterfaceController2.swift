//
//  InterfaceController2.swift
//  FirstWatchApp
//
//  Created by Thomas Attermann on 17/05/2016.
//  Copyright © 2016 Thomas Attermann. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController2: WKInterfaceController {

    // Slider orutlet
    @IBOutlet var slider: WKInterfaceSlider!
    
    // Method for printing values from slider.
    @IBAction func valueChanged(value: Float) {
        print(value)
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }

    override func willActivate() {
        
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
