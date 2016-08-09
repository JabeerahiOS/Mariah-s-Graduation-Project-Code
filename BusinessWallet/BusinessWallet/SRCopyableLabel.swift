//
//  SRCopyableLabel.swift
//  BusinessWallet
//
//  Created by Mariah Sami Khayat on 5/3/16.
//  Copyright © 2016 BusinessWallet. All rights reserved.
//

import Foundation
import UIKit

class SRCopyableLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        sharedInit()
    }
    
    func sharedInit() {
        userInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: "showMenu:"))
    }
    
    func showMenu(sender: AnyObject?) {
        becomeFirstResponder()
        let menu = UIMenuController.sharedMenuController()
        if !menu.menuVisible {
            menu.setTargetRect(bounds, inView: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    
    override func copy(sender: AnyObject?) {
        let board = UIPasteboard.generalPasteboard()
        board.string = text
        let menu = UIMenuController.sharedMenuController()
        menu.setMenuVisible(false, animated: true)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == "copy:" {
            return true
        }
        return false
    }
    
    
}