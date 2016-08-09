//
//  Account.swift
//  BusinessWallet
//
//  Created by Hissah on 3/15/16.
//  Copyright © 2016 BusinessWallet. All rights reserved.
//

import UIKit

class Account: UIViewController {

    let ref = Firebase(url: "https://businesswallet.firebaseio.com/")

    @IBOutlet weak var EmailAddressTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func viewDidAppear(animated: Bool) {
        
        if ref.authData != nil
        {
            print("there is a user already signed in")
            self.performSegueWithIdentifier("SignInSegue", sender: self)
        }
        else
        {
            print("You have to login or sign up")
        }
        
    }




    
    
    @IBAction func SignInButton(sender: AnyObject){
        
        if EmailAddressTF.text == "" || PasswordTF.text == ""
        {
            let alert = UIAlertController(title: "Oops!", message:"Make sure to fill in all required textfields", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        }
            
            
        else
        {
            ref.authUser(EmailAddressTF.text, password: PasswordTF.text,withCompletionBlock: { error, authData in
                    
                    if error != nil {
                        if let errorCode = FAuthenticationError(rawValue: error.code) {
                         
                            switch (errorCode) {
                                
                            case .UserDoesNotExist:
                                print("User Does Not Exist")
                                let alert = UIAlertController(title: "Oops!", message:"This user doesn't exist!", preferredStyle: .Alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                self.presentViewController(alert, animated: true){}
                                
                                
                            case .InvalidPassword:
                                print("Invalid password")
                                let alert = UIAlertController(title: "Oops!", message:"Invalid password! ", preferredStyle: .Alert)
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
                                
                            }
                        }//errors
                        
                        
                    }//if
                    
                    else {
                        
                        
                        
                        
                        //عشان تعديل الإيميل والباسوورد
                        //خزنت قيمة الإيميل والباسوورد هنا
                        NSUserDefaults.standardUserDefaults().setValue(self.EmailAddressTF.text, forKey: "Email")
                        NSUserDefaults.standardUserDefaults().setValue(self.PasswordTF.text, forKey: "password")
                        
                        
                        
                        print("success ")
                        self.performSegueWithIdentifier("SignInSegue", sender: nil)
                    }
            })
        }//1st else
     
        
    }//Sign in button
    

    

    
    
    
    // دالة أضفتها عشان تختفي لوحة المفاتيح لما نلمس أي مكان على الشاشة
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    
    
}
