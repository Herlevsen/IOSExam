//
//  SensorViewController.swift
//  iOSSensorCamera
//
//  Created by Thomas Attermann on 28/05/2016.
//  Copyright © 2016 Thomas Attermann. All rights reserved.
//

import UIKit
import CoreMotion

class SensorViewController: UIViewController {
    
    private let motionManager = CMMotionManager()
    private let queue = NSOperationQueue()
    
    @IBOutlet var gyroscopeLabel:UILabel!
    @IBOutlet var accelerometerLabel:UILabel!
    @IBOutlet var attitudeLabel:UILabel!
    
    var updateTimer:NSTimer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sensor"
        
        
        if motionManager.deviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates()
            updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(SensorViewController.updateDisplay), userInfo: nil, repeats: true)
        }
        
    }
    
    func updateDisplay() {
        let motion = motionManager.deviceMotion
        if (motion != nil) {
            let rotationRate = motion!.rotationRate
            let gravity = motion!.gravity
            let attitude = motion!.attitude
            
            dispatch_async(dispatch_get_main_queue(), {
                self.gyroscopeLabel.text = "Rotation x: \(rotationRate.x)"
                self.accelerometerLabel.text = "Gravity x: \(gravity.x)"
                self.attitudeLabel.text = "Altitude: \(attitude.roll)"
            }) }
    }
    
    
    
}
