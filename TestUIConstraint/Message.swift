//
//  TextMessage.swift
//  ChatBot
//
//  Created by Gavin Ong on 11/7/18.
//  Copyright © 2018 Gavin Ong. All rights reserved.
//

import Foundation


class Message{
    
    var messageID:String?
    var date: Date?
    var text: String?
    var isSender: Bool?
    
    
    init(date:Date,text:String,isSender:Bool){
        self.date = date
        self.text = text
        self.isSender = isSender
    }
    
    
}
