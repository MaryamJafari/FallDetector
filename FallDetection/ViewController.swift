//
//  ViewController.swift
//  FallDetection
//
//  Created by Maryam Jafari on 10/8/17.
//  Copyright © 2017 Maryam Jafari. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    var motionManager = CMMotionManager()
    var detected = false
    let gravity = UIGravityBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.gyroUpdateInterval = 0.2
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.deviceMotionUpdateInterval = 0.1
    }
    
    
    @IBOutlet var detectText: UILabel!
    
    @IBAction func start(_ sender: UIButton) {
        self.detect()
    }
    
    
    @IBAction func stop(_ sender: UIButton) {
        
        detectText.text = "Stop Detecting"
        motionManager.stopAccelerometerUpdates() //Stop update
    }
    func detect() {
        
        self.detectText.text = "Start Detecting..."
        motionManager.startAccelerometerUpdates(to: OperationQueue()) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            let acceleration = accelerometerData!.acceleration
            let droppingDetection = pow(acceleration.x, 2) + pow(acceleration.y, 2) + pow(acceleration.z, 2)
            
            DispatchQueue.main.async(execute: { () -> Void in
                if (droppingDetection < 0.1) {
                    self.detectText.text = "Fall has been Detected"
                    print("Detect phone fall...")
                    self.motionManager.stopAccelerometerUpdates()
                } else {
                    print("Phone is not dropped")
                }
            })
            if(NSError != nil) {
                print("\(String(describing: NSError))")
            }
        }
    }
    
}

