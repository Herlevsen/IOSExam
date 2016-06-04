//
//  IAPManager.swift
//  S16Level2Purchase
//
//  Created by Jon Eikholm on 29-04-16.
//  Copyright © 2016 Jon Eikholm. All rights reserved.
//

import UIKit
import StoreKit

class IAPManager:NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let sharedInstance = IAPManager()
    var productRequest: SKProductsRequest!
    var products: NSArray!  // verified products
    
    func setup(){
        self.validateProducts(getProductsFromMainBundle())
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        
    }
    
    func getProductsFromMainBundle() -> NSArray{
        var products = NSArray()
        if let url = NSBundle.mainBundle().URLForResource("products", withExtension: "plist"){
            products = NSArray(contentsOfURL: url)!
        }
        return products
    }
    
    func validateProducts(products: NSArray){
        let productSet = NSSet(array: products as [AnyObject])
        productRequest = SKProductsRequest(productIdentifiers: productSet as! Set<String>)
        productRequest.delegate = self
        productRequest.start()
    }
    
    // delegate method - called when AppStore returns with a response
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        self.products = response.products
        NSNotificationCenter.defaultCenter().postNotificationName("DidFinishProductRequestNotification", object: nil, userInfo: nil)
        print("products verified by AppStore")
        print("Product array count: \(products.count)")
    }
    
    func createPaymentRequest(product: SKProduct){
        let payment = SKMutablePayment(product: product)
        payment.quantity = 1
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions as [SKPaymentTransaction] {
            switch transaction.transactionState {
            case .Purchasing:
                print("Purchasing...")
            case .Purchased:
                print("Purchased")
                self.verifyReceipt(transaction)
            case .Failed:
                print("failed")
                print(transaction.error?.localizedDescription)
            default: break
            }
        }
    }
    
    func verifyReceipt(transaction: SKPaymentTransaction?){
        let receiptURL = NSBundle.mainBundle().appStoreReceiptURL!
        if let receipt = NSData(contentsOfURL: receiptURL){
            let requestContent = ["receipt-data": receipt.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))]
            do{
                let requestData = try NSJSONSerialization.dataWithJSONObject(requestContent, options: NSJSONWritingOptions(rawValue: 0))
                let storeURL = NSURL(string: "https://sandbox.itunes.apple.com/verifyReceipt")
                // use "buy" og "https" instead of "sandbox" for production
                let request = NSMutableURLRequest(URL: storeURL!)
                request.HTTPMethod = "POST"
                request.HTTPBody = requestData
                let session = NSURLSession.sharedSession() // simple session
                let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                    do {                                // json > Foundation
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as! NSDictionary
                        if json.objectForKey("status") as! NSNumber == 0 {
                            let receipt_dict = json["receipt"] as! NSDictionary
                            if let purchases = receipt_dict["in_app"] as? NSArray{
                                self.validateArrayOfPurchases(purchases)
                            }// now stop transaction
                            // notify, to show newly purchased features:
                            NSNotificationCenter.defaultCenter().postNotificationName("DidFinishProductRequestNotification", object: nil, userInfo: nil)
                            if transaction != nil {
                                SKPaymentQueue.defaultQueue().finishTransaction(transaction!)
                            }
                        }
                    }catch{
                        print("error converting JSON > Foundation")
                    }
                })
                task.resume()
            } catch {
                print("error converting Foundation > JSON")
            }
        } else {
            print("no receipt found locally")
        }
        
        
    }
    
    func validateArrayOfPurchases(purchases: NSArray){
        for purchase in purchases {
            unlockFunctionality(purchase["product_id"] as! String)
        }
    }
    
    func unlockFunctionality(productID: String){
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: productID)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // Status codes for receipt validation:
    // https://developer.apple.com/library/ios/releasenotes/General/ValidateAppStoreReceipt/Chapters/ValidateRemotely.html
}













