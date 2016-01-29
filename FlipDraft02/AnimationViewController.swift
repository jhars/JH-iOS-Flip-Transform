// ************************************ //
// SitterBook Flip-Animation Controller //
// ************************************ //
import UIKit


var baseLayer = false
var sitterFlipBookHasBeenLoaded = false
var tempSitterDisplayDictionary = [ : ]
var tempTimeSlotArrFromAPI = [Int]()
var step:Int = Int()

//protocol AnimationCtlrDelegate {
//    var flipView:FlipView {get}
//}
var flipView = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(-100,100,575,500))
// flipview2??
class AnimationViewController: UIViewController {
//    var flipView = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(-100,100,575,500))
//    var sitterObjArray = [SitterMatchModel]()

    var animationDelegate:AnimationDelegate = AnimationDelegate(sequenceType: kSequenceControlled, directionType: kDirectionNone)
    var timeSlotLabelsOnViewArray = [UILabel]()
    //[[[[[[[[[[ CENTER-BUTTON ]]]]]]]]]]]\\
    @IBOutlet weak var flipThruBtn: UIButton!
    @IBOutlet weak var coverLabel: UILabel!
    
    @IBOutlet weak var schedulizerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var TopNavBar: UINavigationBar!
    @IBOutlet weak var NavBar: UINavigationBar!
    
    @IBOutlet weak var mutualFriendsButton: UIButton!
    
    // ================ SCHEDULIZER ================== //
    //************************************************//
    //MONDAY
    var mon0 = 0;var mon1 = 0;var mon2 = 0
    @IBOutlet weak var MON_0: UILabel!;@IBOutlet weak var MON_1: UILabel!;@IBOutlet weak var MON_2: UILabel!
    //TUESDAY
    var tue0 = 0;var tue1 = 0;var tue2 = 0
    @IBOutlet weak var TUE_0: UILabel!;@IBOutlet weak var TUE_1: UILabel!;@IBOutlet weak var TUE_2: UILabel!
    //WEDNESDAY
    var wed0 = 0;var wed1 = 0;var wed2 = 0
    @IBOutlet weak var WED_0: UILabel!;@IBOutlet weak var WED_1: UILabel!;@IBOutlet weak var WED_2: UILabel!
    //THURSDAY
    var thu0 = 0;var thu1 = 0;var thu2 = 0
    @IBOutlet weak var THU_0: UILabel!;@IBOutlet weak var THU_1: UILabel!;@IBOutlet weak var THU_2: UILabel!
    //FRIDAY
    var fri0 = 0;var fri1 = 0;var fri2 = 0
    @IBOutlet weak var FRI_0: UILabel!;@IBOutlet weak var FRI_1: UILabel!;@IBOutlet weak var FRI_2: UILabel!
    //SATURDAY
    var sat0 = 0;var sat1 = 0;var sat2 = 0
    @IBOutlet weak var SAT_0: UILabel!;@IBOutlet weak var SAT_1: UILabel!;@IBOutlet weak var SAT_2: UILabel!
    //SUNDAY
    var sun0 = 0;var sun1 = 0;var sun2 = 0
    @IBOutlet weak var SUN_0: UILabel!;@IBOutlet weak var SUN_1: UILabel!;@IBOutlet weak var SUN_2: UILabel!
    //**************************************************//
    //--------------- END SCHEDULIZER ----------------- //
    
    // __________________________________ START ViewDidLoad ____________________________//
    override func viewDidLoad() {
        super.viewDidLoad()
        print("on view did load")
        print(tempUserNameIdentifier.count)
        print(tempUserSitterSchedIdentifier.count)
        
        animationDelegate.transformView = flipView
        animationDelegate.controller = self
        animationDelegate.perspectiveDepth = 75000
        animationDelegate.nextDuration = 0.20
        animationDelegate.shadow = true
        animationDelegate.sensitivity = 5000
        animationDelegate.gravity = 32000
        animationDelegate.startAnimation(kDirectionNone)
        
        flipView.font = "HelveticaNeue-Bold"
        flipView.fontSize = 36.0
        flipView.fontAlignment = "right" // not working yet... maybe when words wrap?
        flipView.textOffset = CGPointMake(125.0, 330.0);
        //BASE LAYER
        if baseLayer == false {
            flipView.printText("End of Results", usingImage: nil, backgroundColor: UIColor.lightGrayColor(), textColor: UIColor.blueColor())
            tempUserCnxScoreIdentifier.append(0)
            tempUserSitterNumOfMutualIdentifier.append(0)
            let baseLayerTimeSlot = [ "fri0":0,"fri1":0,"fri2":0,"mon0":0,"mon1":0,"mon2":0,"sat0":0,"sat1":0,"sat2":0,"sun0":0,"sun1":0,"sun2":0,"thu0":0,"thu1":0,"thu2":0,"tue0":0,"tue1":0,"tue2":0,"wed0":0,"wed1":0,"wed2":0]
            tempUserSitterSchedIdentifier.append(baseLayerTimeSlot)
            tempUserNameIdentifier.append("BASE-LAYER")
            
         
            let MatchObject = SitterMatchModel(name: "Base Layer", cnxScore: 0, img: UIImage(named: "page4")!,timeSlots: baseLayerTimeSlot, mutualFriends: ["Base Camp"], numberOfMutualFriends: 0)
            sitterModelObjects.append(MatchObject)
            baseLayer = true
            self.view.addSubview(flipView)
            print("do I need a baseLayer???")
            step = tempUserNameIdentifier.count - 1

        } else {
            print("base layer loaded on initial ViewDidLoad")
        }
        
        // if
        if sitterFlipBookHasBeenLoaded == true {
            print("already loaded")
            self.loadAnimationVcElements()
        } else {
            self.loadGetFlippingButton()
        }
    }
    // _ _ _ _ _ _ _ _ __ _ _ _ _ _ _ END ViewDidLoad  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _//
    
    
    func displayTargetSitterSchedule () {
        self.timeSlotLabelsOnViewArray = [FRI_0, FRI_1,FRI_2,MON_0,MON_1,MON_2,SAT_0,SAT_1,SAT_2,SUN_0,SUN_1,SUN_2,THU_0,THU_1,THU_2,TUE_0,TUE_1,TUE_2,WED_0,WED_1,WED_2]
        tempTimeSlotArrFromAPI = [fri0,fri1,fri2,mon0,mon1,mon2,sat0,sat1,sat2,sun0,sun1,sun2,thu0,thu1,thu2,tue0,tue1,tue2,wed0,wed1,wed2]
        print("update MatchData here");print(step);print("great Print-ChkPnt HERE!!")
        
        let targetMatchData = sitterModelObjects[step]
        
        UserDataHasBeenLoaded = true
        print("userDataHasBeenLoaded =  \(UserDataHasBeenLoaded)")
        
        
        let targetMutualFriendData = targetMatchData.numberOfMutualFriends! as Int
        let mutualBtnTitle =  String(targetMutualFriendData) + " Mutual Connections"
        self.mutualFriendsButton.setTitle(mutualBtnTitle, forState: UIControlState.Normal)
        if step == 0 {
            self.view.sendSubviewToBack(self.mutualFriendsButton)
        } else {
            self.view.bringSubviewToFront(self.mutualFriendsButton)
            print("mutual friends above")
        }
        //Import Data from Model Here!!
        var scheduleDataKeys = ["fri0","fri1","fri2","mon0","mon1","mon2","sat0","sat1","sat2","sun0","sun1","sun2","thu0","thu1","thu2","tue0","tue1","tue2","wed0","wed1","wed2"]
        
        let targetScheduleData = targetMatchData.timeSlots! as NSDictionary
        print(targetScheduleData)
        
        
//        for scheduleIndex in 0...20 {
//            tempTimeSlotArrFromAPI[scheduleIndex] = tempUserSitterSchedIdentifier[step][scheduleDataKeys[scheduleIndex]] as! Int
//            print(tempTimeSlotArrFromAPI)
//            if tempTimeSlotArrFromAPI[scheduleIndex] == 1 {
//                //if matching date, squareColor = Green
//                print(tempUserParentSchedule)
//                if tempUserParentSchedule[scheduleIndex] == true {
//                    self.timeSlotLabelsOnViewArray[scheduleIndex].backgroundColor = UIColor.greenColor()
//                } else {
//                    self.timeSlotLabelsOnViewArray[scheduleIndex].backgroundColor = UIColor.blueColor()
//                }
//            } else {
//                self.timeSlotLabelsOnViewArray[scheduleIndex].backgroundColor = UIColor.grayColor()
//            }
//            print(scheduleIndex)
//        }
        for scheduleIndex in 0...20 {
            tempTimeSlotArrFromAPI[scheduleIndex] = tempUserSitterSchedIdentifier[step][scheduleDataKeys[scheduleIndex]] as! Int
//            print(tempTimeSlotArrFromAPI)
            if tempTimeSlotArrFromAPI[scheduleIndex] == 1 {
                print(tempUserParentSchedule)
                if tempUserParentSchedule[scheduleIndex] == true {
                    self.timeSlotLabelsOnViewArray[scheduleIndex].backgroundColor = UIColor.greenColor()
                } else {
                    self.timeSlotLabelsOnViewArray[scheduleIndex].backgroundColor = UIColor.blueColor()
                }

            } else {
                self.timeSlotLabelsOnViewArray[scheduleIndex].backgroundColor = UIColor.grayColor()
            }
            print(scheduleIndex)
        }
        
//        flipView.printText(sitterNameModel, usingImage: sitterImageModel, backgroundColor: nil, textColor: UIColor.lightGrayColor())
        
    }

    //LOAD AnimationVC elements
    func loadAnimationVcElements () {
        self.flipThruBtn.removeFromSuperview()
        self.coverLabel.removeFromSuperview()
        
        self.view.addSubview(flipView)
        self.view.bringSubviewToFront(schedulizerLabel)
        self.view.bringSubviewToFront(nameLabel)
        self.bringScheduleSquaresToFront()
        print(step)
        print(tempUserNameIdentifier)
        
        if sitterFlipBookHasBeenLoaded == false {
            step = tempUserNameIdentifier.count - 1
            sitterFlipBookHasBeenLoaded = true
        }
        
        self.displayTargetSitterSchedule()
        //========================================================================================================================//
        //========================= PAN-GESTURE ===============================//
        let showGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action: "handleSwipe:")
        showGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        flipView.addGestureRecognizer(showGestureRecognizer)
        //                showGestureRecognizer.maximumNumberOfTouches = 1;
        //        self.panRecognizer.minimumNumberOfTouches = 1;
        let hideGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        hideGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        flipView.addGestureRecognizer(hideGestureRecognizer)
        //===================== END - PAN-GESTURE ============================//
        
        self.bringScheduleSquaresToFront()
    }
    
    func bringScheduleSquaresToFront() {
        for squares in self.timeSlotLabelsOnViewArray {
            self.view.bringSubviewToFront(squares)
        }
    }
    func loadGetFlippingButton() {
        self.view.sendSubviewToBack(flipView)
        self.coverLabel.backgroundColor = UIColor.lightGrayColor()
        self.view.bringSubviewToFront(self.coverLabel)
        self.view.bringSubviewToFront(flipThruBtn)
    }

    var timeSlotIndex:Int = 0
//===========================> (SWIPE - HANDLER) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    func handleSwipe(recognizer:UISwipeGestureRecognizer){
//  Flick-UP => FORWARD
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Up) {
            if step < (tempUserNameIdentifier.count - 1) {
                animationDelegate.startAnimation(kDirectionBackward)
                print("on UP Swipe!")
                step += 1
            } else {
                print("SitterList Endpoint on UP Swipe")

            }
        }
//  Flick-DOWN => BACKWARD
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Down) {
            print("on down swipe")
            if step > 0 {
                animationDelegate.startAnimation(kDirectionForward)
                step -= 1
            } else {
                print("SitterList EndPoint on down swipe")
            }
        }
        self.view.bringSubviewToFront(NavBar);self.view.bringSubviewToFront(TopNavBar);self.view.bringSubviewToFront(schedulizerLabel);self.view.bringSubviewToFront(nameLabel)

        self.bringScheduleSquaresToFront()
        self.displayTargetSitterSchedule()
    }
    // ---------- END HandleSwipe func ---------------//
//================> (thru Sitter Array) >>>>>>>>>>>>>>>>>>>>>>>]]]]]
//[[[[[[[[[[[[[[[[[[[[[[[  MAIN BUTTON  ]]]]]]]]]]]]]]]]]]]]]]]
    @IBAction func tappedFlipThruSitters(sender: AnyObject) {
        self.loadAnimationVcElements()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        animationDelegate.startAnimation(kDirectionNone)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        animationDelegate.resetTransformValues()
//        NSObject.cancelPreviousPerformRequestsWithTarget(animationDelegate)
    }
    

}
