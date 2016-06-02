//
//  SplitViewController.swift
//  iOSEksamen-Views-Controllers-Gestures
//
//  Created by Steffen on 26/05/16.
//  Copyright © 2016 Steffen. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController, UIGestureRecognizerDelegate {

    var detailViewController: DetailViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hej")
        if let split = splitViewController {
            let controllers = split.viewControllers
            print(controllers)
            //detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
