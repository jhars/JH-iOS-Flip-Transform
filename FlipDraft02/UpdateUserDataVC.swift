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

class UpdateUserDataVC: UIViewController {

    
    @IBAction func updatBtnTapped(sender: AnyObject) {
        var userFbookData = self.returnUserData()
    }
    
//    var token  = FBSDKAccessToken.currentAccessToken().tokenString
    @IBOutlet weak var sitterStatus: UISegmentedControl!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    // __________________________________________________________________________ //
    
    var sitterOrNot:Bool = false
    var currentDate = NSDate()
    //  FIREBASE
    var ref = Firebase(url: "https://sitterbookapi.firebaseio.com/")
    @IBAction func parentOrSitter(sender: UISegmentedControl) {
        switch sitterStatus.selectedSegmentIndex{
        case 0:
            sitterOrNot = false
            print("SitterStatus = False")
        case 1:
            print("SitterStatus = True")
            sitterOrNot = true
        default:
            break;
        }
    }
// __________________________________________________________________________ //
// ______________________VIEW DID LOAD_______________________________________ //
// __________________________________________________________________________ //
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FBSDKAccessToken.currentAccessToken().tokenString)
        zipTextField.text = "12345"
        emailTextField.text = "Jon.Harlan@sitterbook.com"
    }
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil)
            { print("Error: \(error)")
            } else {
                let userID : NSString = result.valueForKey("id") as! NSString
                print("User ID is is: \(userID)")
                
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                //Create New User SignUp/Login on FireBase
                let userEmail = self.emailTextField.text! as String
                let userZip = self.zipTextField.text! as String
                let userSitterStatus = self.sitterOrNot as Bool
                let lastLogin = String(NSDate())
                //ZIP CODE on Sign Up / Login
                //=======Update USer INfo FireBase Ref ===========//
                
                let updateUserInfoUrl = "https://sitterbookapi.firebaseio.com/users/" + (userID as String)
                var updateUserInfoRef = Firebase(url: updateUserInfoUrl)
                
                //_________________________________________________//
                //FreBAse OAuth Signup & Login
                self.ref.createUser(userEmail, password: "1111", withValueCompletionBlock:{(result) -> Void in
                    //                    print("success sign up!"); print("User has been Created, result is \(result)")
                    self.ref.authUser(userEmail, password:"1111", withCompletionBlock: { (authData) -> Void in
                        // ===== DATA WRITING ROUTES =========== //
                        updateUserInfoRef.updateChildValues(["token": FBSDKAccessToken.currentAccessToken().tokenString])
//                        updateUserInfoRef.updateChildValues(["testKey": "testValue"])
                        updateUserInfoRef.updateChildValues(["last-login": lastLogin])
                        updateUserInfoRef.updateChildValues(["user-name": userName])
                        updateUserInfoRef.updateChildValues(["email": userEmail])
                        updateUserInfoRef.updateChildValues(["sitter": userSitterStatus])
                        updateUserInfoRef.updateChildValues(["zip": userZip])
                        
                    })
                })
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
