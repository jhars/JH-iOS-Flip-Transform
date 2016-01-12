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

var sitterFlipObjects = [FlipView]()

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
                print("userData has been loaded")
//                self.performSegueWithIdentifier("showSitter", sender: nil)
               
                
            } else {
                
                let userID : NSString = result.valueForKey("id") as! NSString
                print("User ID is is: \(userID)")
                self.currentUserId = userID as String
                self.tempFireBaseUrlForCurrentUser = "https://sitterbookapi.firebaseio.com/users/" + (userID as String)

                
                var userEmail : NSString = result.valueForKey("email") as! NSString
                var AllUserPhotosObject : NSObject = result.valueForKey("photos") as! NSObject

                print(userEmail)
                //You Will need this call to upload images from facebook later, in some other ViewController with a seperate Graph API Call
                var AllUserPhotosData = AllUserPhotosObject.valueForKey("data")?.objectAtIndex(0).valueForKey("id") as! NSObject
                print(AllUserPhotosData)
//                var FirstPhoto = AllUserPhotosData
                
                    //=================================================================\\
                    //   [SITTER MATCH MODEL]()  ->   is this delegation...?
                    //=================================================================\\
                    
                    let currentUserPath = self.tempFireBaseUrlForCurrentUser
                    let fireBaseRef = Firebase(url:(currentUserPath as String) + "/sitter-list/")
                    
                    fireBaseRef.queryOrderedByValue().observeEventType(.ChildAdded, withBlock: { snapshot in
//                        Need To ADD ERROR HANDLING HERE

                        //=================================================================\\
                        let sitterObjDict = snapshot.value as! NSDictionary
                        var imgUrlModel = sitterObjDict["image-url"] as! String
                        
                        let AlamoRef = Alamofire.request(.GET, imgUrlModel)
                        AlamoRef.responseImage { response in
                            if let image = response.result.value {
// INSERT "h ttps://www.facebook.com/()"
                                var sitterImageModel = image
                                var sitterNameModel = sitterObjDict["name"] as! String
                                var sitterScoreModel = sitterObjDict["cnx-score"] as! Int
                                var SitterObject = SitterMatchModel(name: sitterNameModel, cnxScore: sitterScoreModel, img: sitterImageModel)
                                sitterModelObjects.append(SitterObject)
                                flipView.printText(sitterNameModel, usingImage: sitterImageModel, backgroundColor: nil, textColor: UIColor.whiteColor())
                            }
                            AlamoRef.resume()
                            UserDataHasBeenLoaded = true
                        } // ==== End Almao Ref =====//
                    }) // |DB| ====== END FIRE BASE ========= |DB| //
            } // ----- END 'else' Statement --------------//
            self.performSegueWithIdentifier("showSitter", sender: nil)
//            task.reloadDate()
        }) // - - - - - - - - END Graph Request - - - - - - - - - - - - - - //
    } //============================ END  func returnUserData() ============================== //
//    func sitterObjectLoader () {
//        for sitter in sitterModelObjects {
//            print(" - - - - - - - sitter Obj Loading Below - - - - - - -")
//            if sitter.img != nil && sitter.name != nil {
//                flipView.printText(sitter.name!, usingImage: sitter.img!, backgroundColor: nil, textColor: UIColor.blueColor())
//                self.view.addSubview(flipView)
//                print(sitter.name!)
//                print(sitter.cnxScore!)
//                print("sitter Loaded!")
//            } else {
//                print("sitterObject == nil")
//            }
//        }
//    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let newsTVC = segue.destinationViewController as! AnimationViewController
        newsTVC.sitterObjArray = sitterModelObjects
    }
}
