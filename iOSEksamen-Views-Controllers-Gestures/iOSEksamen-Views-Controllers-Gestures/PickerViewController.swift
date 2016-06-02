//
//  PickerViewController.swift
//  iOSEksamen-Views-Controllers-Gestures
//
//  Created by Steffen on 26/05/16.
//  Copyright © 2016 Steffen. All rights reserved.
//

import UIKit

// must implement the following:
// UIPickerViewDataSource, UIPickerViewDelegate
// Then implement the required delegate methods - can be found in the documentation
// MARK: - Class declaration
class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fruitLabel: UILabel!
    
    // MARK: - UIPickerView data
    let fruits = ["Apple", "Banana", "Pear"]

    // MARK: - Set UIPickerView delegate & dataSource
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Swipe left
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(PickerViewController.leftSwipe(_:)))
        swipeLeft.numberOfTouchesRequired = 1
        swipeLeft.direction = .Left
        swipeLeft.delegate = self
        
        self.view.addGestureRecognizer(swipeLeft)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions
    @IBAction func datePickerAction(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let date = dateFormatter.stringFromDate(datePickerView.date)
        self.dateLabel.text = date
    }
    
    // MARK: - UIPickerView delegate methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruits.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fruits[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.fruitLabel.text = fruits[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Method to handle swipe left
    func leftSwipe(sender: UISwipeGestureRecognizer) {
        print("left swipe")
        // Identifier set in storyboard in the identify inspector tab
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("EmbedTableView") as! EmbedTableViewVC
        self.navigationController?.pushViewController(nextVC, animated: true)
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
