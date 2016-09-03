//
//  ViewController.swift
//  checkMates
//
//  Created by Gregory Berns-Leone on 9/2/16.
//  Copyright © 2016 checkMates. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DwollaAPIManager.sharedInstance.startOAuth2Login()
        print("Sent off")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

