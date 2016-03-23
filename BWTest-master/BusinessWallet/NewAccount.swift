//
//  NewAccount.swift
//  BusinessWallet
//
//  Created by Hissah on 3/15/16.
//  Copyright © 2016 BusinessWallet. All rights reserved.
//

import UIKit

class NewAccount: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate , UITextViewDelegate {
    
    let ref = Firebase(url: "https://businesswallet.firebaseio.com/")
    
    @IBOutlet weak var NewAccountSV: UIScrollView!
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
        NewAccountSV.contentSize.height=1440
        
        
        //أضفت هنا قيمه مبدئية لو ما حرك المستخدم ال picker  لأنه لو ما أضفت هذا السطر والمستخدم ما حرك ال picker  القيمة الموجودة فيه ماراح تعتبر راح يعتبر أنها empty strig
        itemSelected = CategoryArray[0]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // هنا أضفت المتغير اللي راح استخدمة عشان قيمة ال picker
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
        //هذي الدالة أضفتها عشان آخذ العنصر الموجود في ال picker  كقيمة استخدمها عشان اخليها في الfirebase المتغير معرفته فوق ومعطيته قيمه مبدئية عرفته برا عشان ما يكون محلي فقط بالدالة
                itemSelected = CategoryArray[row]
    }
    
    

    
    
    
    @IBAction func CreatButton(sender: AnyObject) {
        
        if EmailAddressTF.text=="" || PasswordTF.text=="" || BusinessNameTF.text==""
        {
            let alert = UIAlertController(title: "Oops!", message:"Make sure to fill in all required textfields", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        }
            
        else
        {
            if RepasswordTF.text != PasswordTF.text
            {
                let alert = UIAlertController(title: "Oops!", message:"You Entered Different Passwords", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                self.presentViewController(alert, animated: true){}
            }
                
                
            else
            {
                let ref = Firebase(url: "https://businesswallet.firebaseio.com/")
                
                ref.createUser(EmailAddressTF.text, password: PasswordTF.text, withValueCompletionBlock:
                    {error, result in
                        
                        if error != nil
                        {
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
                        }
                            
                        else
                        {
                            ref.authUser(self.EmailAddressTF.text, password: self.PasswordTF.text, withCompletionBlock: { (error, authData) -> Void in
                                
                                if error != nil {
                                    print(error.description)
                                }
                                    
                                else
                                {
                                    
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
                                    
                                    //عشان تعديل الإيميل والباسوورد
                                    //خزنت قيمة الإيميل والباسوورد هنا
                                    NSUserDefaults.standardUserDefaults().setValue(self.EmailAddressTF.text, forKey: "Email")
                                    NSUserDefaults.standardUserDefaults().setValue(self.PasswordTF.text, forKey: "password")
                                    
                                    
                                    print("Success!")
                                    self.ref.childByAppendingPath("Users").childByAppendingPath(authData.uid).setValue(newUser)
                                    
                                    self.performSegueWithIdentifier("CreateAccountSegue", sender: nil)
                                    
                                    
                                }
                            })
                            
                        }
                        
                })
            }
        }
    }

    
  
    
    
    //هذي دالة عشان ال textview  لما نضغط عليه يطلع فوق وما يكون تحت الكيبورد
    func textViewDidBeginEditing(textView: UITextView) {
        if textView == DetailsTV{
            NewAccountSV.setContentOffset(CGPointMake(0, 630), animated: true)
        }
    }
    
    //هذي الدالة لما نخلص كتابة في الtextview  يرجعه مكانه ما يبقى طالع فوق
    func textViewDidEndEditing(textView: UITextView) {
        NewAccountSV.setContentOffset(CGPointMake(0, -58), animated: true)
    }
    
    
    
    
    
    
    //هنا المقاسات عشان كل مره السكرول view يتحرك لل field المطلوب بشكل مناسب مع الكيبورد
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField == EmailAddressTF{
            NewAccountSV.setContentOffset(CGPointMake(0, -58), animated: true)
        }
        if textField == PasswordTF{
            NewAccountSV.setContentOffset(CGPointMake(0, -58), animated: true)
        }
        if textField == RepasswordTF{
            NewAccountSV.setContentOffset(CGPointMake(0, -58), animated: true)
        }
        if textField == BusinessNameTF{
            NewAccountSV.setContentOffset(CGPointMake(0, -58), animated: true)
        }
        if textField == ShortDescriptionTF{
            NewAccountSV.setContentOffset(CGPointMake(0, 60), animated: true)
        }
        if textField == CityTF{
            NewAccountSV.setContentOffset(CGPointMake(0, 130), animated: true)
        }
        if textField == ContactMeTF{
            NewAccountSV.setContentOffset(CGPointMake(0, 200), animated: true)
        }
        if textField == PhoneNumberTF{
            NewAccountSV.setContentOffset(CGPointMake(0, 280), animated: true)
        }
        if textField == Website1TF{
            NewAccountSV.setContentOffset(CGPointMake(0, 410), animated: true)
        }
        if textField == Website2TF{
            NewAccountSV.setContentOffset(CGPointMake(0, 410), animated: true)
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

    
    
    
    
}
    
    
    
    
    
    
    
