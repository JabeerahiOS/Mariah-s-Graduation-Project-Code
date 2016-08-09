//
//  FirstViewController.swift
//  BusinessWallet
//
//  Created by Hissah on 3/10/16.
//  Copyright © 2016 BusinessWallet. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    @IBAction func emailUrl(sender: AnyObject) {
        let email = "Business.Wallet@hotmail.com"
        let mailurl = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(mailurl!)
    }
  

    @IBAction func twitterUrl(sender: AnyObject) {
        if let url = NSURL(string: "http://twitter.com/BusinessWallet") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

