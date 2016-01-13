//
//  UpdateUserDataVC.swift
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

var CurrentUserID = String()

class UpdateUserDataVC: UIViewController {
    
    var sitterOrNot:Bool = false
    var currentDate = NSDate()
//  FIREBASE
    var ref = Firebase(url: "https://sitterbookapi.firebaseio.com/")

    @IBOutlet weak var sitterStatus: UISegmentedControl!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func updatBtnTapped(sender: AnyObject) {
        self.returnUserData()
    }
    
    @IBAction func sitterOrParent(sender: UISegmentedControl) {
        switch sitterStatus.selectedSegmentIndex{
            case 0:
                self.sitterOrNot = false
                print("SitterStatus = False")
            case 1:
                print("SitterStatus = True")
                self.sitterOrNot = true
            default:
                break;
        }
    }

// __________________________________________________________________________ //
// ______________________VIEW DID LOAD_______________________________________ //
// __________________________________________________________________________ //
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.returnUserData()
        zipTextField.text = "12345"
        emailTextField.text = "ThisWontPostToFireBase@SitterBook.com"
    }
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters:  ["fields" : "email,id,name"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil)
            { print("Error: \(error)")
            } else {
                print(self.sitterOrNot)
                let userID : NSString = result.valueForKey("id") as! NSString
                print("User ID is is: \(userID)")
                CurrentUserID = userID as String
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print(result)
//EMAIL TEXT FIELD:
//                self.emailTextField.text = userEmail as String
//                let userEmail = self.emailTextField.text! as String
                let userZip = self.zipTextField.text! as String
                let userSitterStatus = self.sitterOrNot as Bool
                let lastLogin = String(NSDate())

                let userProfileImgUrl = "https://graph.facebook.com/" + (userID as String) + "/picture?width=720&redirect=false"
                
                let AlamoRef = Alamofire.request(.GET,userProfileImgUrl ,parameters: ["data": "url"])
                    .responseJSON { response in
// HANDLE ERRORS HERE =====>>>>>
                        let imageEndPointRespone = response.result.value?.valueForKey("data")?.valueForKey("url")
                        print(imageEndPointRespone)
                        let imgObject = imageEndPointRespone as! NSString
                        let tempImgUrl = imageEndPointRespone as! String

                        
// - - - - - - - - - - - - - - - - - - - FIREBASE - - - - - - - - - - - - - - - - - - - //
                        //=======Update USer INfo FireBase Ref ===========//
                        let updateUserInfoUrl = "https://sitterbookapi.firebaseio.com/users/" + (userID as String)
                        let updateUserInfoRef = Firebase(url: updateUserInfoUrl)
                        
                        if self.sitterOrNot != true {
                            print("user is parent")
                            updateUserInfoRef.updateChildValues(["parent": userZip])
                        } else {
                            print("user is sitter")
                            updateUserInfoRef.updateChildValues(["parent": false])
                        }
                        updateUserInfoRef.updateChildValues(["token": FBSDKAccessToken.currentAccessToken().tokenString])
                        updateUserInfoRef.updateChildValues(["profileImgUrl": tempImgUrl])
                        updateUserInfoRef.updateChildValues(["lastLogin": lastLogin])
                        updateUserInfoRef.updateChildValues(["userName": userName])
                        updateUserInfoRef.updateChildValues(["email": userEmail])
                        updateUserInfoRef.updateChildValues(["sitter": userSitterStatus])
                        updateUserInfoRef.updateChildValues(["zip": userZip])
                }
            }
        })
    }
    // ******************* SIGN-UP ********************** //
    func signUp(sender: AnyObject) {
        //        if emailTextField.text == "" || passwordTextField.text == "" {
        //            print("make sure to enter in each textfield")
        //        } else {
        // ===== Sign Up Logic Here ======== //
        //        }
    }
    // ********************************************************** //

}
