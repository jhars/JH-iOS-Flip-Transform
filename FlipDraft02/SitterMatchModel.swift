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
    var cnxScore:Float?
    var img:UIImage?
    var timeSlots:NSDictionary?
    var mutualFriends:NSArray?
    var numberOfMutualFriends:Int?
    
//    init(name:String, cnxScore:Int,img:UIImage) {
    init(name:String, cnxScore:Float,img:UIImage,timeSlots:NSDictionary,mutualFriends:NSArray,numberOfMutualFriends:Int) {
        self.name = name
        self.cnxScore = cnxScore
        self.img = img
        self.timeSlots = timeSlots
        self.mutualFriends = mutualFriends
        self.numberOfMutualFriends = numberOfMutualFriends
    }
}
