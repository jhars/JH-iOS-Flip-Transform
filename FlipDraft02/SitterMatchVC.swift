//
//  SitterMatchVC.swift
//  FlipDraft02
//
//  Created by Jon Harlan on 1/9/16.
//  Copyright © 2016 Jon Harlan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

var sitterMatchModelName = [String]()
var sitterMatchModelScore = [Int]()
var sitterModelObjects = [SitterMatchModel]()

class SitterMatchVC: UIViewController {
    
    var currentUserId:String = ""
    var tempFireBaseUrlForCurrentUser:String = ""
    var cnxImageUrl:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
//        sitterModelObjects.removeAll()
        returnUserData()
    }
    
    let fireBaseRef = Firebase(url: "https://sitterbookapi.firebaseio.com/users/")
    //=================================================================\\
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        let task = graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil)
            {   // Process error
                print("Error: \(error)")
            } else {
                
                let userID : NSString = result.valueForKey("id") as! NSString
                print("User ID is is: \(userID)")
                self.currentUserId = userID as String
                self.tempFireBaseUrlForCurrentUser = "https://sitterbookapi.firebaseio.com/users/" + (userID as String)
                
                let currentUserPath = self.tempFireBaseUrlForCurrentUser
                let firebaseRef = Firebase(url:(currentUserPath as String) + "/sitter-list/")
                
                firebaseRef.queryOrderedByValue().observeEventType(.ChildAdded, withBlock: { snapshot in
//                self.fireBaseRef.observeEventType(.Value, withBlock: { snapshot in
                    //Need To ADD ERROR HANDLING HERE
                    print(snapshot.value)
                    //=================================================================\\
                    //       IMAGES HERE - - - - - - - - - - } AlamoRef.resume()       \\
                    //=================================================================\\
                })
            } // ----- END 'else' Statement --------------//
            self.performSegueWithIdentifier("showSitter", sender: nil)
        }) // - - - - - - - - END Graph Request - - - - - - - - - - - - - - //

    } //============================ END  func returnUserData() ============================== //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let newsTVC = segue.destinationViewController as! FlipBrowseSittersVC
        newsTVC.models = sitterModelObjects
    }
}
