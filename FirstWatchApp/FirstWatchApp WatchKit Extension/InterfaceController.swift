//
//  InterfaceController.swift
//  FirstWatchApp WatchKit Extension
//
//  Created by Thomas Attermann on 17/05/2016.
//  Copyright © 2016 Thomas Attermann. All rights reserved.
//

import WatchKit
import Foundation

// InterfaceController is the equivalent of ViewControllers
class InterfaceController: WKInterfaceController {

    @IBOutlet var myLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var message = NSMutableAttributedString(string: "I am legend")
        
        // Add content to label with color attribute
        message.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(),  range: NSMakeRange(0, 5))
        myLabel.setAttributedText(message)
        
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
