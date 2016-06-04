//
//  ViewController.swift
//  S16Level2Purchase
//
//  Created by Jon Eikholm on 29-04-16.
//  Copyright © 2016 Jon Eikholm. All rights reserved.
//  com.joneikholm.level2

import UIKit
import StoreKit

class ViewController: UIViewController {

    @IBOutlet weak var level2Button: UIButton!
    let featureLevel2 = "com.joneikholm.level2"
    @IBAction func purchaseBtnPressed(sender: UIButton) {
        let product = IAPManager.sharedInstance.products.objectAtIndex(0) as! SKProduct
        IAPManager.sharedInstance.createPaymentRequest(product)
        setLockStatus()
    }
    
    
     // loop through all items, and display those which are payed for
    func setLockStatus(){
        for product in IAPManager.sharedInstance.products {
            if let prod = product as? SKProduct{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if prod.productIdentifier == self.featureLevel2 {
                    if NSUserDefaults.standardUserDefaults().boolForKey(prod.productIdentifier) {
                        self.level2Button.enabled = true
                    }else {
                     print("nsuserdefaults was false")   
                    }
                }
               })
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        level2Button.enabled = false
        // add observer to call setLockStatus() when AppStore 
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.setLockStatus), name: "DidFinishProductRequestNotification", object: nil)

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

