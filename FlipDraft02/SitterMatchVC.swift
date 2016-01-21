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
import Alamofire
import AlamofireImage

var sitterMatchModelName = [String]()
var sitterMatchModelScore = [Int]()
var sitterModelObjects = [SitterMatchModel]()
var UserDataHasBeenLoaded = false

//var tempSitterDisplayDictionary:NSDictionary = [String : NSArray<String>]()
//var tempSitterDisplayDictionary = [String : Array<String>]()
//var tempSitterDisplayDictionary = [ : ]


var tempUserNameIdentifier = [String]()
var tempUserCnxScoreIdentifier = [Int]()
var tempUserSitterSchedIdentifier = [NSDictionary]()

class SitterMatchVC: UIViewController {
    
    var currentUserId:String = ""
    var tempFireBaseUrlForCurrentUser:String = ""
    var cnxImageUrl:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        //remove all
        returnUserData()
    }
    
    let fireBaseRef = Firebase(url: "https://sitterbookapi.firebaseio.com/users/")
    //=================================================================\\
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "email,id,name,photos"])
        let task = graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil)
            {   // Process error
                print("Error: \(error)")
            }  else if (UserDataHasBeenLoaded == true) {
                print("UserDataHasBeenLoaded == true")
            } else {
                
                let userID : NSString = result.valueForKey("id") as! NSString
                print("User ID is is: \(userID)")
                self.currentUserId = userID as String
                self.tempFireBaseUrlForCurrentUser = "https://sitterbookapi.firebaseio.com/users/" + (userID as String)

                let userEmail : NSString = result.valueForKey("email") as! NSString
                print(userEmail)


                    //=================================================================\\
                    //   [SITTER MATCH MODEL]()  ->   is this delegation...?
                    //=================================================================\\
                    
                    let currentUserPath = self.tempFireBaseUrlForCurrentUser
                    let fireBaseRef = Firebase(url:(currentUserPath as String) + "/sitterList/")
                    
                    fireBaseRef.queryOrderedByValue().observeEventType(.ChildAdded, withBlock: { snapshot in
//Need To ADD ERROR HANDLING HERE
                        if snapshot.value != nil {
                            let sitterObjDict = snapshot.value as! NSDictionary
                            let imgUrlModel = sitterObjDict["profileImgUrl"] as! String
                        
                            let AlamoRef = Alamofire.request(.GET, imgUrlModel)
                            AlamoRef.responseImage { response in
                                if let image = response.result.value {
                                    
                                    let sitterImageModel = image
                                    let sitterNameModel = sitterObjDict["userName"] as! String
                                    let sitterScoreModel = sitterObjDict["cnxScore"] as! Int
//                                    for schedMatches
                                    let sitterTimeArrayModel = sitterObjDict["sitterSchedMatches"] as! NSDictionary
//                                    print(sitterTimeArrayModel)
                                    
                                    let SitterObject = SitterMatchModel(name: sitterNameModel, cnxScore: sitterScoreModel, img: sitterImageModel,timeSlots: sitterTimeArrayModel)
//                                    let SitterObject = SitterMatchModel(name: sitterNameModel, cnxScore: sitterScoreModel, img: sitterImageModel)
//                                    print(SitterObject.name)
//                                    print(SitterObject.cnxScore)
//                                    print(SitterObject.timeSlots)

                                    sitterModelObjects.append(SitterObject)
                                    flipView.printText(sitterNameModel, usingImage: sitterImageModel, backgroundColor: nil, textColor: UIColor.lightGrayColor())
//                                    step += 1
                                    
                                    tempUserNameIdentifier.append(sitterNameModel)
                                    tempUserCnxScoreIdentifier.append(sitterScoreModel)
                                    tempUserSitterSchedIdentifier.append(sitterTimeArrayModel)
                                    //Arrays load in SAME Order, this is good!
                                    //You can pair/sync them together have
                                    //schedule cycle as you flip
                                    //using the name OR index as an identifier
                                    //but I still need the name in the flipView Object
                                    
                                    
//                                    var tempFlipperView = flipView.printText(sitterNameModel, usingImage: sitterImageModel, backgroundColor: nil, textColor: UIColor.lightGrayColor())
//                                    print(tempFlipperView)
                                    
//                                    if ((SitterObject.timeSlots?) != nil) {
//                                        print(SitterObject.timeSlots)
//                                    }
                                }
                                AlamoRef.resume()
                                UserDataHasBeenLoaded = true
                            } // @l@m0 - - - - - End Almao Ref - - - - - - - - //
                        
                        } else {
                            print("no Sitter Data Available")
                        }// ----- END 'if/else' ... directly above --------\\
                    }) // |DB| ====== END FIRE BASE ========= |DB| //
            } // ----- END 'else' Statement --------------//
            self.performSegueWithIdentifier("showSitter", sender: nil)
//            task.reloadDate()
        }) // - - - - END Graph Request - - -  - //
    } //============================ END  func returnUserData() ============================== //

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let newsTVC = segue.destinationViewController as! AnimationViewController
//        newsTVC.sitterObjArray = sitterModelObjects
//    }
}
