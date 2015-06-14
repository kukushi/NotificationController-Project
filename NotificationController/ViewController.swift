//
//  ViewController.swift
//  NotificationController
//
//  Created by kukushi on 3/1/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var count = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        notificationController.observe("cool", object: nil) { (notification) -> Void in
            self.count = 2;
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSNotificationCenter.defaultCenter().postNotificationName("cool", object: nil)
        print(count)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

