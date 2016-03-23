//
//  YourAccount.swift
//  BusinessWallet
//
//  Created by Hissah on 3/15/16.
//  Copyright © 2016 BusinessWallet. All rights reserved.
//

import UIKit

class YourAccount: UIViewController {
    
    var ref = Firebase(url: "https://businesswallet.firebaseio.com/")
    
    @IBOutlet weak var YourAccountSV: UIScrollView!
    @IBOutlet weak var EmailL: UILabel!
    @IBOutlet weak var BusinessNameL: UILabel!
    @IBOutlet weak var ShortDesciptionL: UILabel!
    @IBOutlet weak var CategoryL: UILabel!
    @IBOutlet weak var CityL: UILabel!
    @IBOutlet weak var ContactMeL: UILabel!
    @IBOutlet weak var PhoneNumberL: UILabel!
    @IBOutlet weak var Website1L: UILabel!
    @IBOutlet weak var Website2L: UILabel!
    @IBOutlet weak var DetailsTV: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Scroll bar length
        YourAccountSV.contentSize.height=1120
       
        let ref = Firebase(url: "https://businesswallet.firebaseio.com/Users/\(self.ref.authData.uid)")
          ref.observeEventType(.Value , withBlock: {snapshot in
            self.EmailL.text =  snapshot.value.objectForKey("Email") as? String
            self.BusinessNameL.text =  snapshot.value.objectForKey("BusinessName") as? String
            self.ShortDesciptionL.text =  snapshot.value.objectForKey("ShortDescription") as? String
            self.CategoryL.text =  snapshot.value.objectForKey("Category") as? String
            self.CityL.text =  snapshot.value.objectForKey("City") as? String
            self.ContactMeL.text =  snapshot.value.objectForKey("ContactMe") as? String
            self.PhoneNumberL.text =  snapshot.value.objectForKey("PhoneNumber") as? String
            self.Website1L.text =  snapshot.value.objectForKey("Website1") as? String
            self.Website2L.text =  snapshot.value.objectForKey("Website2") as? String
            self.DetailsTV.text =  snapshot.value.objectForKey("Details") as? String
        })
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func LogUotButton(sender: AnyObject) {
        ref.unauth()
        
        //بدال ال Segeue
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
    
    @IBAction func EditButton(sender: AnyObject) {
        // Edit Button func
    }

    
    
    
    
}