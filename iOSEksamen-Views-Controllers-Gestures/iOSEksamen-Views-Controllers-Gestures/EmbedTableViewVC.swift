//
//  EmbedTableViewVC.swift
//  iOSEksamen-Views-Controllers-Gestures
//
//  Created by Steffen on 27/05/16.
//  Copyright © 2016 Steffen. All rights reserved.
//

import UIKit

class EmbedTableViewVC: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView Data
    let cars = ["Audi", "Toyota", "Opel", "BMW"]

    // MARK: - IBOutlets
    @IBOutlet weak var selectedLabel: UILabel!
    @IBOutlet weak var embedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the title of the navigation bar
        self.title = "EmbedTableView"
        // Swipe left
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(EmbedTableViewVC.leftSwipe(_:)))
        swipeLeft.numberOfTouchesRequired = 1
        swipeLeft.direction = .Left
        swipeLeft.delegate = self
        
        // add the gesture to the view
        self.view.addGestureRecognizer(swipeLeft)
        
        // set the uitableview delegate & datasource
        self.embedTableView.delegate = self
        self.embedTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Method to handle swipe left
    func leftSwipe(sender: UISwipeGestureRecognizer) {
        print("left swipe")
        // Identifier set in storyboard in the identify inspector tab
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("TableViewController") as! TableViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - TableView data source methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // set the cell to our custom subclass of UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("embedCell", forIndexPath: indexPath) as! CustomCell
        cell.textLabel?.text = cars[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedLabel.text = cars[indexPath.row]
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
