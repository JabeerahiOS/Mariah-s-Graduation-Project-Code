//
//  EditAccountViewController.swift
//  BusinessWallet
//
//  Created by Mariah Sami Khayat on 3/16/16.
//  Copyright © 2016 BusinessWallet. All rights reserved.
//

import UIKit

class EditAccountViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate {

    var ref = Firebase(url: "https://businesswallet.firebaseio.com/")
    
    
    @IBOutlet weak var EditAccountSV: UIScrollView!
    @IBOutlet weak var EmailAddressTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var RepasswordTF: UITextField!
    @IBOutlet weak var BusinessNameTF: UITextField!
    @IBOutlet weak var ShortDescriptionTF: UITextField!
    @IBOutlet weak var CtegoryPV: UIPickerView!
    @IBOutlet weak var CityTF: UITextField!
    @IBOutlet weak var ContactMeTF: UITextField!
    @IBOutlet weak var PhoneNumberTF: UITextField!
    @IBOutlet weak var Website1TF: UITextField!
    @IBOutlet weak var Website2TF: UITextField!
    @IBOutlet weak var DetailsTV: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CtegoryPV.delegate=self
        CtegoryPV.dataSource=self
        
        // Scroll bar length
        EditAccountSV.contentSize.height=1440

        itemSelected = CategoryArray[0]
        

        let ref = Firebase(url: "https://businesswallet.firebaseio.com/Users/\(self.ref.authData.uid)")
        ref.observeEventType(.Value , withBlock: {snapshot in
            self.EmailAddressTF.text =  snapshot.value.objectForKey("Email") as? String
            self.PasswordTF.text = snapshot.value.objectForKey("Provider") as? String
            self.BusinessNameTF.text =  snapshot.value.objectForKey("BusinessName") as? String
            self.ShortDescriptionTF.text =  snapshot.value.objectForKey("ShortDescription") as? String
            
            let C =  snapshot.value.objectForKey("Category") as? String
          
            //To retrieve the picker choice that the user selected when he created the account. ;)
            self.itemSelected = C as String!
            let indexOfA = self.CategoryArray.indexOf(self.itemSelected)
            self.CtegoryPV.selectRow(indexOfA!, inComponent: 0, animated: true)
            
            self.CityTF.text =  snapshot.value.objectForKey("City") as? String
            self.ContactMeTF.text =  snapshot.value.objectForKey("ContactMe") as? String
            self.PhoneNumberTF.text =  snapshot.value.objectForKey("PhoneNumber") as? String
            self.Website1TF.text =  snapshot.value.objectForKey("Website1") as? String
            self.Website2TF.text =  snapshot.value.objectForKey("Website2") as? String
            self.DetailsTV.text =  snapshot.value.objectForKey("Details") as? String
        })
        
        
        
    } //ViewDidLoad

    
    
    
    
   
    var itemSelected = ""
    
    var CategoryArray:[String]=["Cheefs","Beauty","Student Services","Art & Designe","Store", "Others"]
    
    //ثلاثة دوال عشان الpicker
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CategoryArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CategoryArray.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        itemSelected = CategoryArray[row]
    }

    

    
    
    
    
    @IBAction func Done(sender: AnyObject) {
        
        
        if EmailAddressTF.text=="" || PasswordTF.text=="" || BusinessNameTF.text==""
        {
            let alert = UIAlertController(title: "Oops!", message:"Make sure to fill in all required textfields", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        }
        
        else {
            
            if RepasswordTF.text != PasswordTF.text
            {
                let alert = UIAlertController(title: "Oops!", message:"You Entered Different Passwords", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                self.presentViewController(alert, animated: true){}
            }
            
            else {
            
                let ref = Firebase(url: "https://businesswallet.firebaseio.com/")
                
                let mainpass = NSUserDefaults.standardUserDefaults().objectForKey("password") as? String
                let mainEmail = NSUserDefaults.standardUserDefaults().objectForKey("Email") as? String
                
                
                let isEqu = (mainEmail == self.EmailAddressTF.text)
                if(isEqu == true)
                {   }
                else
                {
                    ref.changeEmailForUser(mainEmail, password: mainpass, toNewEmail: self.EmailAddressTF.text, withCompletionBlock: { error in
                        
                        if error != nil {
                            
                            if let errorCode = FAuthenticationError(rawValue: error.code) {
                                
                                switch (errorCode) {
                                case .EmailTaken:
                                    print("Email taken")
                                    let alert = UIAlertController(title: "Oops!", message:"Sorry,Email taken", preferredStyle: .Alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                    self.presentViewController(alert, animated: true){}
                                    
                                case .InvalidEmail:
                                    print("invalid email")
                                    let alert = UIAlertController(title: "Oops!", message:"invalid email", preferredStyle: .Alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                    self.presentViewController(alert, animated: true){}
                                    
                                    
                                case .NetworkError:
                                    print("Network Error")
                                    let alert = UIAlertController(title: "Oops!", message:"Network error, check your connection", preferredStyle: .Alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                    self.presentViewController(alert, animated: true){}
                                    
                                default:
                                    print("Unknown Error")
                                    let alert = UIAlertController(title: "Oops!", message:"Unknown Error", preferredStyle: .Alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                    self.presentViewController(alert, animated: true){}
                                }
                            }
                            
                            
                            
                            
                            
                        } else {
                            
                            NSUserDefaults.standardUserDefaults().setValue(self.EmailAddressTF.text, forKey: "Email")
                            print("Email changed successfully")
                            
                        }
                        
                    })
                    
                } //Big Else
                
                
                
                
                
                ref.changePasswordForUser( NSUserDefaults.standardUserDefaults().objectForKey("Email") as? String, fromOld: NSUserDefaults.standardUserDefaults().objectForKey("password") as? String, toNew: self.PasswordTF.text)
                    {
                        
                        (ErrorType) -> Void in
                        if ErrorType != nil {
                            print(ErrorType)
                            print("There was an error processing the request")
                        }
                        else
                        {
                            
                            NSUserDefaults.standardUserDefaults().setValue(self.PasswordTF.text, forKey: "password")
                            print("Password changed successfully")
                            
                        }
                        
                }
                
                
                let newUser = [
                    "Provider": self.PasswordTF.text!,
                    "Email": self.EmailAddressTF.text,
                    "BusinessName": self.BusinessNameTF.text ,
                    "ShortDescription" : self.ShortDescriptionTF.text,
                    "Category" : self.itemSelected,
                    "City" : self.CityTF.text,
                    "ContactMe" : self.ContactMeTF.text,
                    "PhoneNumber" : self.PhoneNumberTF.text,
                    "Website1": self.Website1TF.text,
                    "Website2": self.Website2TF.text,
                    "Details": self.DetailsTV.text
                ]

           
                self.ref.childByAppendingPath("Users").childByAppendingPath(self.ref.authData.uid).updateChildValues(newUser)
                self.navigationController?.popViewControllerAnimated(true)
            
            
            } //Another Big Else
            
        } //Big Big Else
        

} //Done Button
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //هذي دالة عشان ال textview  لما نضغط عليه يطلع فوق وما يكون تحت الكيبورد
    func textViewDidBeginEditing(textView: UITextView) {
        if textView == DetailsTV{
            EditAccountSV.setContentOffset(CGPointMake(0, 630), animated: true)
        }
    }
    
    //هذي الدالة لما نخلص كتابة في الtextview  يرجعه مكانه ما يبقى طالع فوق
    func textViewDidEndEditing(textView: UITextView) {
        EditAccountSV.setContentOffset(CGPointMake(0, -58), animated: true)
    }
    
    
    
    
    
    
    //هنا المقاسات عشان كل مره السكرول view يتحرك لل field المطلوب بشكل مناسب مع الكيبورد
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField == EmailAddressTF{
            EditAccountSV.setContentOffset(CGPointMake(0, -58), animated: true)
        }
        if textField == PasswordTF{
            EditAccountSV.setContentOffset(CGPointMake(0, -58), animated: true)
        }
        if textField == RepasswordTF{
            EditAccountSV.setContentOffset(CGPointMake(0, -58), animated: true)
        }
        if textField == BusinessNameTF{
            EditAccountSV.setContentOffset(CGPointMake(0, -58), animated: true)
        }
        if textField == ShortDescriptionTF{
            EditAccountSV.setContentOffset(CGPointMake(0, 60), animated: true)
        }
        if textField == CityTF{
            EditAccountSV.setContentOffset(CGPointMake(0, 130), animated: true)
        }
        if textField == ContactMeTF{
            EditAccountSV.setContentOffset(CGPointMake(0, 200), animated: true)
        }
        if textField == PhoneNumberTF{
            EditAccountSV.setContentOffset(CGPointMake(0, 280), animated: true)
        }
        if textField == Website1TF{
            EditAccountSV.setContentOffset(CGPointMake(0, 410), animated: true)
        }
        if textField == Website2TF{
            EditAccountSV.setContentOffset(CGPointMake(0, 410), animated: true)
        }
        
    }
    
    
    
    // هذي الدالة عشان لما نضغط next تمشي لل field اللي بعده
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        
        if textField == self.EmailAddressTF {
            self.PasswordTF.becomeFirstResponder()
        }
        if textField == self.PasswordTF {
            self.RepasswordTF.becomeFirstResponder()
        }
        if textField == self.RepasswordTF {
            self.BusinessNameTF.becomeFirstResponder()
        }
        if textField == self.BusinessNameTF {
            self.ShortDescriptionTF.becomeFirstResponder()
        }
        if textField == self.CityTF {
            self.ContactMeTF.becomeFirstResponder()
        }
        if textField == self.ContactMeTF {
            self.PhoneNumberTF.becomeFirstResponder()
        }
        if textField == self.PhoneNumberTF {
            self.Website1TF.becomeFirstResponder()
        }
        if textField == self.Website1TF {
            self.Website2TF.becomeFirstResponder()
        }
        if textField == self.Website2TF {
            self.DetailsTV.becomeFirstResponder()
        }
        
        return true
    }
    
    
    
    

    
    
    

} //UI
