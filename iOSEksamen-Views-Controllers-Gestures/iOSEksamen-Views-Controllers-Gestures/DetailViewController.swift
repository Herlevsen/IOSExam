//
//  DetailViewController.swift
//  iOSEksamen-Views-Controllers-Gestures
//
//  Created by Steffen on 27/05/16.
//  Copyright © 2016 Steffen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailText = ""
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        detailLabel.text = detailText
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
