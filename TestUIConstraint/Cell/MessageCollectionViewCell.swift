//
//  MessageCollectionViewCell.swift
//  TestUIConstraint
//
//  Created by Gavin Ong on 18/7/18.
//  Copyright © 2018 Gavin Ong. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var chatLogMessageTextView: UITextView!
    
    
    @IBOutlet var chatLogMessageHeight: NSLayoutConstraint!
    
    
    @IBOutlet var cellLeading: NSLayoutConstraint!
    
    
    @IBOutlet var cellTrailing: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupMessageCell(cell: MessageCollectionViewCell){
        
        
    }
    
    

}
