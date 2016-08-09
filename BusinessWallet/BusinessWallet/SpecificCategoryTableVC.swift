//
//  SpecificCategoryTablrVC.swift
//  BusinessWallet
//
//  Created by Hissah on 4/10/16.
//  Copyright © 2016 BusinessWallet. All rights reserved.
//

import UIKit

class SpecificCategoryTableVC: UITableViewController, UISearchResultsUpdating{
    

    var resultSearchController = UISearchController(searchResultsController: nil)
    var filteredUsers: NSMutableArray = []
    
    var BusinessNamesArray: NSMutableArray = []

    var titlestring: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titlestring

        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.tableView.reloadData()

        //
        self.navigationItem.title = titlestring
        
        
        let ref = Firebase(url: "https://businesswallet.firebaseio.com/Users")
        
        ref.queryOrderedByChild("Category").queryEqualToValue(titlestring)
            .observeEventType(.Value, withBlock: { snapshot in

                if let dict = snapshot.value as? NSMutableDictionary{
                    //print("dict======print \(dict)")
                    
                    for (key,value) in dict {
                        let mainDict = NSMutableDictionary()
                        mainDict.setObject(key, forKey: "userid")
                        
                        
                        if let dictnew = value as? NSMutableDictionary{
                            
                            if let metname = dictnew["BusinessName"] as? String
                            {
                                mainDict.setObject(metname, forKey: "BusinessName")
                            }
                            if let metname = dictnew["ShortDescription"] as? String
                            {
                                mainDict.setObject(metname, forKey: "ShortDescription")
                            }
                            if let metname = dictnew["Category"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Category")
                            }
                            if let metname = dictnew["City"] as? String
                            {
                                mainDict.setObject(metname, forKey: "City")
                            }
                            if let metname = dictnew["ContactMe"] as? String
                            {
                                mainDict.setObject(metname, forKey: "ContactMe")
                            }
                            if let metname = dictnew["Details"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Details")
                            }
                            if let metname = dictnew["Email"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Email")
                            }
                            if let metname = dictnew["PhoneNumber"] as? String
                            {
                                mainDict.setObject(metname, forKey: "PhoneNumber")
                            }
                            if let metname = dictnew["Provider"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Provider")
                            }
                            if let metname = dictnew["Website1"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Website1")
                            }
                            if let metname = dictnew["Website2"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Website2")
                            }
                        }
                        //print("mainDict========= \(mainDict)")
                        self.BusinessNamesArray.addObject(mainDict)
                        //print("mainDict2========= \(mainDict)")
                    }
                    //print("array is \(self.BusinessNamesArray)")
                }
                self.tableView.reloadData()
                
            })
    }



   
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.active
        {
            return self.filteredUsers.count
        }else
        {
            return BusinessNamesArray.count
        }
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as UITableViewCell
        
        if self.resultSearchController.active
        {
            if let name = self.filteredUsers[indexPath.row] as? NSMutableDictionary{
                
                cell.textLabel?.text = name["BusinessName"] as? String
                cell.detailTextLabel?.text = name["ShortDescription"] as? String
            }
        }
        else{
            
            if let name = BusinessNamesArray[indexPath.row] as? NSMutableDictionary{
                
                cell.textLabel?.text = name["BusinessName"] as? String
                cell.detailTextLabel?.text = name["ShortDescription"] as? String
            }
        }
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if self.resultSearchController.active
        {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                let detailsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProjectDetailsViewController") as! DetailsViewController
                
                if let name = self.filteredUsers[indexPath.row] as? NSMutableDictionary{
                    
                    
                    detailsViewController.self.strUserid = name["userid"] as? String
                }
                
                self.navigationController?.pushViewController(detailsViewController, animated: true)
                
            }
            
        }
        else
        {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                let detailsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProjectDetailsViewController") as! DetailsViewController
                
                if let name = self.BusinessNamesArray[indexPath.row] as? NSMutableDictionary{
                    
                    detailsViewController.self.strUserid = name["userid"] as? String
                }
                
                self.navigationController?.pushViewController(detailsViewController, animated: true)
                
            }
            
            
        }
    }


    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredUsers.removeAllObjects()
        
        //attributeA contains[cd] $A OR attributeB contains[cd]
        let searchPredicate = NSPredicate(format: "BusinessName contains[cd] %@ OR ShortDescription contains[cd] %@", searchController.searchBar.text!,searchController.searchBar.text!)
        let array = (BusinessNamesArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        for type in array {
            // Do something
            
            filteredUsers .addObject(type)
        }
        
        // filteredUsers = array as! [String]
        
        self.tableView.reloadData()
    }

}

