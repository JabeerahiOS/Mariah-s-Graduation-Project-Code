//
//  CategoryCell.swift
//  BusinessWallet
//
//  Created by Hissah on 4/8/16.
//  Copyright © 2016 BusinessWallet. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    
    
    @IBOutlet weak var CaegoryCellImage: UIImageView!
    @IBOutlet weak var CaegoryCellTitle: UILabel!
    @IBOutlet weak var CaegoryCellDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    //My code:
    
    func configureCell(Image:UIImage, Title:String , Description:String)
    {
        CaegoryCellImage.image = Image
        CaegoryCellTitle.text = Title
        CaegoryCellDescription.text = Description
    }

}
