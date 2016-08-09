//
//  ForgrtPassword.swift
//  BusinessWallet
//
//  Created by Hissah on 3/15/16.
//  Copyright © 2016 BusinessWallet. All rights reserved.
//

import UIKit

class ForgrtPassword: UIViewController {
    
    let ref = Firebase(url: "https://businesswallet.firebaseio.com/")
    
    @IBOutlet weak var EmailTF: UITextField!
    
    
    
    
    @IBAction func SendButton(sender: AnyObject) {
        
        if EmailTF.text == ""
        {
            let alert = UIAlertController(title: "Oops!", message:"Make sure to fill in the required text field", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        }
            
        else
        {
            ref.resetPasswordForUser(EmailTF.text){ (error) -> Void in
                
                if error != nil
                {
                    
                    if let errorCode = FAuthenticationError(rawValue: error.code) {
                        
                        switch (errorCode) {
                            
                        case .UserDoesNotExist:
                            print("User Doesn't Exist")
                            let alert = UIAlertController(title: "Oops!", message:"This user doesn't exist", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                            self.presentViewController(alert, animated: true){}
                            
                            
                        case .NetworkError:
                            print("Network Error")
                            let alert = UIAlertController(title: "Oops!", message:"Network error, check your connection", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                            self.presentViewController(alert, animated: true){}
                            
                            
                        case .InvalidEmail:
                            print("invalid email")
                            let alert = UIAlertController(title: "Oops!", message:"invalid email", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                            self.presentViewController(alert, animated: true){}
                            
                        default:
                            print("Unknown Error")
                            let alert = UIAlertController(title: "Oops!", message:"Unknown Error", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                            self.presentViewController(alert, animated: true){}
                            
                            
                        }//switch
                        
                    }//if
                }// if
                    
                else
                {
                    print("Success")
                    if let Email = self.EmailTF.text{
                        let alert = UIAlertController(title: "Sucess!", message:"Password reset sent to your email address  ( \(Email) )" , preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                        self.presentViewController(alert, animated: true){}
                    }
                    
                }//else
                
            }
        }//1st else
        
        
        
    }//send button

    

}
