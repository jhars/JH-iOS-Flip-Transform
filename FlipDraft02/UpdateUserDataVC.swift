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
//        baseLayer = false
//        sitterFlipBookHasBeenLoaded = false
//        UserDataHasBeenLoaded = false

//        sitterMatchModelName.removeAll()
//        sitterMatchModelScore.removeAll()
//        sitterModelObjects.removeAll()
//        
//        tempUserNameIdentifier.removeAll()
//        tempUserCnxScoreIdentifier.removeAll()
//        tempUserSitterSchedIdentifier.removeAll()
//        tempUserSitterNumOfMutualIdentifier.removeAll()
//        flipView.imageStackArray.removeAllObjects()
        
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
    var Monday0 = false;var Monday1 = false;var Monday2 = false
    var Tuesday0 = false;var Tuesday1 = false;var Tuesday2 = false
    var Wednesday0 = false;var Wednesday1 = false;var Wednesday2 = false
    var Thursday0 = false;var Thursday1 = false;var Thursday2 = false
    var Friday0 = false;var Friday1 = false;var Friday2 = false
    var Saturday0 = false;var Saturday1 = false;var Saturday2 = false
    var Sunday0 = false;var Sunday1 = false;var Sunday2 = false
    
    @IBOutlet weak var m0: UIButton!;   @IBOutlet weak var m1: UIButton!;   @IBOutlet weak var m2: UIButton!
    @IBOutlet weak var t0: UIButton!;    @IBOutlet weak var t1: UIButton!;    @IBOutlet weak var t2: UIButton!
    @IBOutlet weak var w0: UIButton!;    @IBOutlet weak var w1: UIButton!;    @IBOutlet weak var w2: UIButton!
    @IBOutlet weak var th0: UIButton!;    @IBOutlet weak var th1: UIButton!;    @IBOutlet weak var th2: UIButton!
    @IBOutlet weak var f0: UIButton!;    @IBOutlet weak var f1: UIButton!;    @IBOutlet weak var f2: UIButton!
    @IBOutlet weak var sat0: UIButton!;    @IBOutlet weak var sat1: UIButton!;    @IBOutlet weak var sat2: UIButton!
    @IBOutlet weak var sun0: UIButton!;    @IBOutlet weak var sun1: UIButton!;    @IBOutlet weak var sun2: UIButton!
    
//MONDAY
    @IBAction func chooseMon0(sender: AnyObject) {if Monday0 == false {Monday0 = true;m0.backgroundColor = UIColor.blueColor()} else {Monday0 = false;m0.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseMon1(sender: AnyObject) {if Monday1 == false {Monday1 = true;m1.backgroundColor = UIColor.blueColor()} else {Monday1 = false;m1.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseMon2(sender: AnyObject) {if Monday2 == false {Monday2 = true;m2.backgroundColor = UIColor.blueColor()} else {Monday2 = false;m2.backgroundColor = UIColor.whiteColor()}}
//TUESDAY
    @IBAction func chooseTue0(sender: AnyObject) {if Tuesday0 == false {Tuesday0 = true;t0.backgroundColor = UIColor.blueColor()} else {Tuesday0 = false;t0.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseTue1(sender: AnyObject) {if Tuesday1 == false {Tuesday1 = true;t1.backgroundColor = UIColor.blueColor()} else {Tuesday1 = false;t1.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseTue2(sender: AnyObject) {if Tuesday2 == false {Tuesday2 = true;t2.backgroundColor = UIColor.blueColor()} else {Tuesday2 = false;t2.backgroundColor = UIColor.whiteColor()}}
//WEDNESDAY
    @IBAction func chooseWed0(sender: AnyObject) {if Wednesday0 == false {Wednesday0 = true;w0.backgroundColor = UIColor.blueColor()} else {Wednesday0 = false;w0.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseWed1(sender: AnyObject) {if Wednesday1 == false {Wednesday1 = true;w1.backgroundColor = UIColor.blueColor()} else {Wednesday1 = false;w1.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseWed2(sender: AnyObject) {if Wednesday2 == false {Wednesday2 = true;w2.backgroundColor = UIColor.blueColor()} else {Wednesday2 = false;w2.backgroundColor = UIColor.whiteColor()}}
//THURSDAY
    @IBAction func chooseThu0(sender: AnyObject) {if Thursday0 == false {Thursday0 = true;th0.backgroundColor = UIColor.blueColor()} else {Thursday0 = false;th0.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseThu1(sender: AnyObject) {if Thursday1 == false {Thursday1 = true;th1.backgroundColor = UIColor.blueColor()} else {Thursday1 = false;th1.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseThu2(sender: AnyObject) {if Thursday2 == false {Thursday2 = true;th2.backgroundColor = UIColor.blueColor()} else {Thursday2 = false;th2.backgroundColor = UIColor.whiteColor()}}
//FRIDAY
    @IBAction func chooseFri0(sender: AnyObject) {if Friday0 == false {Friday0 = true;f0.backgroundColor = UIColor.blueColor()} else {Friday0 = false;f0.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseFri1(sender: AnyObject) {if Friday1 == false {Friday1 = true;f1.backgroundColor = UIColor.blueColor()} else {Friday1 = false;f1.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseFri2(sender: AnyObject) {if Friday2 == false {Friday2 = true;f2.backgroundColor = UIColor.blueColor()} else {Friday2 = false;f2.backgroundColor = UIColor.whiteColor()}}
//SATURDAY
    @IBAction func chooseSat0(sender: AnyObject) {if Saturday0 == false {Saturday0 = true;sat0.backgroundColor = UIColor.blueColor()} else { Saturday0 = false;sat0.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseSat1(sender: AnyObject) {if Saturday1 == false {Saturday1 = true;sat1.backgroundColor = UIColor.blueColor()} else {Saturday1 = false;sat1.backgroundColor = UIColor.whiteColor()}}
    @IBAction func chooseSat2(sender: AnyObject) {if Saturday2 == false {Saturday2 = true;sat2.backgroundColor = UIColor.blueColor()} else {Saturday2 = false;sat2.backgroundColor = UIColor.whiteColor()}}
//SUNDAY
    @IBAction func chooseSun0(sender: AnyObject) { if Sunday0 == false { Sunday0 = true; sun0.backgroundColor = UIColor.blueColor() } else { Sunday0 = false; sun0.backgroundColor = UIColor.whiteColor() } }
    @IBAction func chooseSun1(sender: AnyObject) { if Sunday1 == false { Sunday1 = true; sun1.backgroundColor = UIColor.blueColor() } else { Sunday1 = false; sun1.backgroundColor = UIColor.whiteColor() } }
    @IBAction func chooseSun2(sender: AnyObject) { if Sunday2 == false { Sunday2 = true; sun2.backgroundColor = UIColor.blueColor() } else { Sunday2 = false; sun2.backgroundColor = UIColor.whiteColor() } }
    


// __________________________________________________________________________ //
// ______________________VIEW DID LOAD_______________________________________ //
// __________________________________________________________________________ //
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.returnUserData()
        zipTextField.text = "12345"
        emailTextField.text = "ThisWontPostToFireBase@SitterBook.com"
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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


                let userProfileImgUrl = "https://graph.facebook.com/" + (userID as String) + "/picture?width=720&redirect=false"
                
                let AlamoRef = Alamofire.request(.GET,userProfileImgUrl ,parameters: ["data": "url"])
                    .responseJSON { response in
// HANDLE ERRORS HERE =====>>>>>
                        let userZip = self.zipTextField.text! as String
                        let userSitterStatus = self.sitterOrNot as Bool
                        let lastLogin = String(NSDate())
                        let imageEndPointRespone = response.result.value?.valueForKey("data")?.valueForKey("url")
                        print(imageEndPointRespone)
                        let imgObject = imageEndPointRespone as! NSString
                        let tempImgUrl = imageEndPointRespone as! String

                        
// - - - - - - - - - - - - - - - - - - - FIREBASE - - - - - - - - - - - - - - - - - - - //
                        //=======Update USer INfo FireBase Ref ===========//
                        let updateUserInfoUrl = "https://sitterbookapi.firebaseio.com/users/" + (userID as String)
                        let updateParentScheduleUrl = updateUserInfoUrl + "/parentSched"
                        let updateSitterScheduleUrl = updateUserInfoUrl + "/sitterSched"
                        let updateUserInfoRef = Firebase(url: updateUserInfoUrl)
                        let updateParentSchedRef = Firebase (url: updateParentScheduleUrl)
                        let updateSitterSchedRef = Firebase(url: updateSitterScheduleUrl)
                        
                        if self.sitterOrNot != true {
                            print("user is parent")
                            updateUserInfoRef.updateChildValues(["parent": userZip])
                            updateParentSchedRef.updateChildValues(["mon0" : self.Monday0])
                            updateParentSchedRef.updateChildValues(["mon1" : self.Monday1])
                            updateParentSchedRef.updateChildValues(["mon2" : self.Monday2])
                            updateParentSchedRef.updateChildValues(["tue0" : self.Tuesday0])
                            updateParentSchedRef.updateChildValues(["tue1" : self.Tuesday1])
                            updateParentSchedRef.updateChildValues(["tue2" : self.Tuesday2])
                            updateParentSchedRef.updateChildValues(["wed0" : self.Wednesday0])
                            updateParentSchedRef.updateChildValues(["wed1" : self.Wednesday1])
                            updateParentSchedRef.updateChildValues(["wed2" : self.Wednesday2])
                            updateParentSchedRef.updateChildValues(["thu0" : self.Thursday0])
                            updateParentSchedRef.updateChildValues(["thu1" : self.Thursday1])
                            updateParentSchedRef.updateChildValues(["thu2" : self.Thursday2])
                            updateParentSchedRef.updateChildValues(["fri0" : self.Friday0])
                            updateParentSchedRef.updateChildValues(["fri1" : self.Friday1])
                            updateParentSchedRef.updateChildValues(["fri2" : self.Friday2])
                            updateParentSchedRef.updateChildValues(["sat0" : self.Saturday0])
                            updateParentSchedRef.updateChildValues(["sat1" : self.Saturday1])
                            updateParentSchedRef.updateChildValues(["sat2" : self.Saturday2])
                            updateParentSchedRef.updateChildValues(["sun0" : self.Sunday0])
                            updateParentSchedRef.updateChildValues(["sun1" : self.Sunday1])
                            updateParentSchedRef.updateChildValues(["sun2" : self.Sunday2])
                        } else {
                            print("user is sitter")
                            updateUserInfoRef.updateChildValues(["parent": false])
                            updateSitterSchedRef.updateChildValues(["mon0" : self.Monday0])
                            updateSitterSchedRef.updateChildValues(["mon1" : self.Monday1])
                            updateSitterSchedRef.updateChildValues(["mon2" : self.Monday2])
                            updateSitterSchedRef.updateChildValues(["tue0" : self.Tuesday0])
                            updateSitterSchedRef.updateChildValues(["tue1" : self.Tuesday1])
                            updateSitterSchedRef.updateChildValues(["tue2" : self.Tuesday2])
                            updateSitterSchedRef.updateChildValues(["wed0" : self.Wednesday0])
                            updateSitterSchedRef.updateChildValues(["wed1" : self.Wednesday1])
                            updateSitterSchedRef.updateChildValues(["wed2" : self.Wednesday2])
                            updateSitterSchedRef.updateChildValues(["thu0" : self.Thursday0])
                            updateSitterSchedRef.updateChildValues(["thu1" : self.Thursday1])
                            updateSitterSchedRef.updateChildValues(["thu2" : self.Thursday2])
                            updateSitterSchedRef.updateChildValues(["fri0" : self.Friday0])
                            updateSitterSchedRef.updateChildValues(["fri1" : self.Friday1])
                            updateSitterSchedRef.updateChildValues(["fri2" : self.Friday2])
                            updateSitterSchedRef.updateChildValues(["sat0" : self.Saturday0])
                            updateSitterSchedRef.updateChildValues(["sat1" : self.Saturday1])
                            updateSitterSchedRef.updateChildValues(["sat2" : self.Saturday2])
                            updateSitterSchedRef.updateChildValues(["sun0" : self.Sunday0])
                            updateSitterSchedRef.updateChildValues(["sun1" : self.Sunday1])
                            updateSitterSchedRef.updateChildValues(["sun2" : self.Sunday2])
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
