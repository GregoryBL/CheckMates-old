//
//  ViewController.swift
//  checkMates
//
//  Created by Gregory Berns-Leone on 9/2/16.
//  Copyright © 2016 checkMates. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var OAuthTokenCompletionHandler : (NSError? -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadInitialData()
        print("Sent off")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

func loadInitialData() {
    if (!DwollaAPIManager.sharedInstance.hasOAuthToken()) {
        DwollaAPIManager.sharedInstance.startOAuth2Login()
    } else {
        // Make a request
    }
}

