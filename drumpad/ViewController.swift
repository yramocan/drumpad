//
//  ViewController.swift
//  drumpad
//
//  Created by Yuri Ramocan on 3/13/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func padTapped(button: UIButton) {
        button.backgroundColor = UIColor.red
        print("You've tapped Pad #\(button.tag)!")
    }

}

