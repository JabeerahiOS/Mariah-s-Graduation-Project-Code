//
//  CategoriesViewController.swift
//  BusinessWallet
//
//  Created by Hissah on 4/8/16.
//  Copyright © 2016 BusinessWallet. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var CategoriesTV: UITableView!
    
    
    var CategoryImage = [UIImage(named: "Cooking"), UIImage(named: "Beauty"), UIImage(named: "StudentServices"), UIImage(named: "ArtAndDesign") , UIImage(named: "Stores") , UIImage(named: "Others")]
    var CategoryTitle: NSMutableArray = ["Cooking","Beauty","Student Services","Art & Design","Stores","Others"]
    var CategoryDescription = ["Sweet, desert.", "Make up artist, hair stylest." , "Ducument translator, programmer, private tutors." , "Interior design, graphic design, montage, draftsman, event coordinator, fashion design." , "Clothes, books, electronics." , "..."]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesTV.delegate = self
        CategoriesTV.dataSource = self
    }

    // My code:
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell") as? CategoryCell
        {
            var img: UIImage!
            img = CategoryImage[indexPath.row]
            
            cell.configureCell(img, Title: CategoryTitle[indexPath.row] as! String, Description: CategoryDescription[indexPath.row])
            return cell
        }else
        {
            return CategoryCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryTitle.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ShowCategoryDetails", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let upcoming: SpecificCategoryTableVC = segue.destinationViewController as! SpecificCategoryTableVC
        let myindexpath = self.CategoriesTV.indexPathForSelectedRow
        let titleString = self.CategoryTitle.objectAtIndex((myindexpath?.row)!) as? String
        
        upcoming.titlestring = titleString
        
        self.CategoriesTV.deselectRowAtIndexPath(myindexpath!, animated: true)
    }
    
    
    
}
