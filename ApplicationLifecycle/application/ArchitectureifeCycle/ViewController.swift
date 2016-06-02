//
//  ViewController.swift
//  ArchitectureifeCycle
//
//  Created by Jens Herlevsen on 31/05/2016.
//  Copyright © 2016 jensherlevsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
    }
    
    override func viewWillAppear(animated: Bool) {
        print(#function)
    }
    
    override func viewDidAppear(animated: Bool) {
        print(#function)
    }
    
    override func viewWillDisappear(animated: Bool) {
        print(#function)
    }
    
    override func viewDidDisappear(animated: Bool) {
        print(#function)
    }
    
    @IBAction func returnedFromView(segue: UIStoryboardSegue) {
        print(#function)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Can be triggered from simulator: Hardware > Simulate Memory Warning
        print(#function)
    }


}

