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
    
    //@IBOutlet weak var YourAccountSV: UIScrollView!
   // @IBOutlet weak var EmailL: UILabel!
    @IBOutlet weak var EmailTV: UITextView!
    @IBOutlet weak var BusinessNameL: SRCopyableLabel!
    @IBOutlet weak var ShortDesciptionL: SRCopyableLabel!
    @IBOutlet weak var CategoryL: SRCopyableLabel!
    @IBOutlet weak var CityL: SRCopyableLabel!
    //@IBOutlet weak var ContactMeL: UILabel!
    @IBOutlet weak var ContactMeTV: UITextView!
    //@IBOutlet weak var PhoneNumberL: UILabel!
    @IBOutlet weak var PhoneNumberTV: UITextView!
    //@IBOutlet weak var Website1L: UILabel!
    @IBOutlet weak var Website1TV: UITextView!
    //@IBOutlet weak var Website2L: UILabel!
    @IBOutlet weak var Website2TV: UITextView!
    @IBOutlet weak var DetailsTV: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Scroll bar length
        //YourAccountSV.contentSize.height=1120
       
        let ref = Firebase(url: "https://businesswallet.firebaseio.com/Users/\(self.ref.authData.uid)")
          ref.observeEventType(.Value , withBlock: {snapshot in
            self.EmailTV.text =  snapshot.value.objectForKey("Email") as? String
            self.BusinessNameL.text =  snapshot.value.objectForKey("BusinessName") as? String
            self.ShortDesciptionL.text =  snapshot.value.objectForKey("ShortDescription") as? String
            self.CategoryL.text =  snapshot.value.objectForKey("Category") as? String
            self.CityL.text =  snapshot.value.objectForKey("City") as? String
            self.ContactMeTV.text =  snapshot.value.objectForKey("ContactMe") as? String
            self.PhoneNumberTV.text =  snapshot.value.objectForKey("PhoneNumber") as? String
            self.Website1TV.text =  snapshot.value.objectForKey("Website1") as? String
            self.Website2TV.text =  snapshot.value.objectForKey("Website2") as? String
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