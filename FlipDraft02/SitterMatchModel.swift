//
//  SitterMatchModel.swift
//  FlipDraft02
//
//  Created by Jon Harlan on 1/9/16.
//  Copyright © 2016 Jon Harlan. All rights reserved.
//

import Foundation

class SitterMatchModel: NSObject {
    var name:String?
    var cnxScore:Int?
    var img:UIImage?
    var timeSlots:NSDictionary?
    var mutualFriends:NSDictionary?
    
//    init(name:String, cnxScore:Int,img:UIImage) {
    init(name:String, cnxScore:Int,img:UIImage,timeSlots:NSDictionary,mutualFriends:NSDictionary) {
        self.name = name
        self.cnxScore = cnxScore
        self.img = img
        self.timeSlots = timeSlots
        self.mutualFriends = mutualFriends
    }
}
