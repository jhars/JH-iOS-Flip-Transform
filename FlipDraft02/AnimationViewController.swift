// ************************************ //
// SitterBook Flip-Animation Controller //
// ************************************ //
import UIKit



var baseLayer = false
var sitterFlipBookHasBeenLoaded = false
var tempSitterDisplayDictionary = [ : ]
var tempTimeSlotArrFromAPI = [Int]()
var step:Int = Int()

var flipView = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(-100,100,575,500))

class AnimationViewController: UIViewController {

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
    
// ================ SCHEDULIZER ================== //
//************************************************//

    //MONDAY
    var mon0 = 0;var mon1 = 0;var mon2 = 0
    @IBOutlet weak var MON_0: UILabel!
    @IBOutlet weak var MON_1: UILabel!
    @IBOutlet weak var MON_2: UILabel!
    //TUESDAY
    var tue0 = 0;var tue1 = 0;var tue2 = 0
    @IBOutlet weak var TUE_0: UILabel!
    @IBOutlet weak var TUE_1: UILabel!
    @IBOutlet weak var TUE_2: UILabel!
    //WEDNESDAY
    var wed0 = 0;var wed1 = 0;var wed2 = 0
    @IBOutlet weak var WED_0: UILabel!
    @IBOutlet weak var WED_1: UILabel!
    @IBOutlet weak var WED_2: UILabel!
    //THURSDAY
    var thu0 = 0;var thu1 = 0;var thu2 = 0
    @IBOutlet weak var THU_0: UILabel!
    @IBOutlet weak var THU_1: UILabel!
    @IBOutlet weak var THU_2: UILabel!
    //FRIDAY
    var fri0 = 0;var fri1 = 0;var fri2 = 0
    @IBOutlet weak var FRI_0: UILabel!
    @IBOutlet weak var FRI_1: UILabel!
    @IBOutlet weak var FRI_2: UILabel!
    //SATURDAY
    var sat0 = 0;var sat1 = 0;var sat2 = 0
    @IBOutlet weak var SAT_0: UILabel!
    @IBOutlet weak var SAT_1: UILabel!
    @IBOutlet weak var SAT_2: UILabel!
    //SUNDAY
    var sun0 = 0;var sun1 = 0;var sun2 = 0
    @IBOutlet weak var SUN_0: UILabel!
    @IBOutlet weak var SUN_1: UILabel!
    @IBOutlet weak var SUN_2: UILabel!
//**************************************************//
    var dictionary: [UILabel:Int] = [:]
//--------------- END SCHEDULIZER ----------------- //

    
    func displayTargetSitterSchedule () {
        print("update schedulizer here")
        print(step)
        print("great error HERE!!")
//Getting All UserData in Model (as opposed to seperate & unsynced arrays...)
        //will allow us to call this data much easier

//Friday
        self.fri0 = tempUserSitterSchedIdentifier[step]["fri0"] as! Int
        self.fri1 = tempUserSitterSchedIdentifier[step]["fri1"] as! Int
        self.fri2 = tempUserSitterSchedIdentifier[step]["fri2"] as! Int
        
        if self.fri0 == 1 { self.FRI_0.backgroundColor = UIColor.blueColor() } else { self.FRI_0.backgroundColor = UIColor.greenColor() }
        if self.fri1 == 1 { self.FRI_1.backgroundColor = UIColor.blueColor() } else { self.FRI_1.backgroundColor = UIColor.greenColor() }
        if self.fri2 == 1 { self.FRI_2.backgroundColor = UIColor.blueColor() } else { self.FRI_2.backgroundColor = UIColor.greenColor() }
        
//Monday
        self.mon0 = tempUserSitterSchedIdentifier[step]["mon0"] as! Int
        self.mon1 = tempUserSitterSchedIdentifier[step]["mon1"] as! Int
        self.mon2 = tempUserSitterSchedIdentifier[step]["mon2"] as! Int
        
        if self.mon0 == 1 { self.MON_0.backgroundColor = UIColor.blueColor() } else { self.MON_0.backgroundColor = UIColor.greenColor() }
        if self.mon1 == 1 { self.MON_1.backgroundColor = UIColor.blueColor() } else { self.MON_1.backgroundColor = UIColor.greenColor() }
        if self.mon2 == 1 { self.MON_2.backgroundColor = UIColor.blueColor() } else { self.MON_2.backgroundColor = UIColor.greenColor() }
        
//Saturday
        self.sat0 = tempUserSitterSchedIdentifier[step]["sat0"] as! Int
        self.sat1 = tempUserSitterSchedIdentifier[step]["sat1"] as! Int
        self.sat2 = tempUserSitterSchedIdentifier[step]["sat2"] as! Int
        if self.sat0 == 1 { self.SAT_0.backgroundColor = UIColor.blueColor() } else { self.SAT_0.backgroundColor = UIColor.greenColor() }
        if self.sat1 == 1 { self.SAT_1.backgroundColor = UIColor.blueColor() } else { self.SAT_1.backgroundColor = UIColor.greenColor() }
        if self.sat2 == 1 { self.SAT_2.backgroundColor = UIColor.blueColor() } else { self.SAT_2.backgroundColor = UIColor.greenColor() }
//Sunday
        self.sun0 = tempUserSitterSchedIdentifier[step]["sun0"] as! Int
        self.sun1 = tempUserSitterSchedIdentifier[step]["sun1"] as! Int
        self.sun2 = tempUserSitterSchedIdentifier[step]["sun2"] as! Int
        
        if self.sun0 == 1 { self.SUN_0.backgroundColor = UIColor.blueColor() } else { self.SUN_0.backgroundColor = UIColor.greenColor() }
        if self.sun1 == 1 { self.SUN_1.backgroundColor = UIColor.blueColor() } else { self.SUN_1.backgroundColor = UIColor.greenColor() }
        if self.sun2 == 1 { self.SUN_2.backgroundColor = UIColor.blueColor() } else { self.SUN_2.backgroundColor = UIColor.greenColor() }
//Thursday
        self.thu0 = tempUserSitterSchedIdentifier[step]["thu0"] as! Int
        self.thu1 = tempUserSitterSchedIdentifier[step]["thu1"] as! Int
        self.thu2 = tempUserSitterSchedIdentifier[step]["thu2"] as! Int
        
        if self.thu0 == 1 { self.THU_0.backgroundColor = UIColor.blueColor() } else { self.THU_0.backgroundColor = UIColor.greenColor() }
        if self.thu1 == 1 { self.THU_1.backgroundColor = UIColor.blueColor() } else { self.THU_1.backgroundColor = UIColor.greenColor() }
        if self.thu2 == 1 { self.THU_2.backgroundColor = UIColor.blueColor() } else { self.THU_2.backgroundColor = UIColor.greenColor() }
//Tuesday
        self.tue0 = tempUserSitterSchedIdentifier[step]["tue0"] as! Int
        self.tue1 = tempUserSitterSchedIdentifier[step]["tue1"] as! Int
        self.tue2 = tempUserSitterSchedIdentifier[step]["tue2"] as! Int
        
        if self.tue0 == 1 { self.TUE_0.backgroundColor = UIColor.blueColor() } else { self.TUE_0.backgroundColor = UIColor.greenColor() }
        if self.tue1 == 1 { self.TUE_1.backgroundColor = UIColor.blueColor() } else { self.TUE_1.backgroundColor = UIColor.greenColor() }
        if self.tue2 == 1 { self.TUE_2.backgroundColor = UIColor.blueColor() } else { self.TUE_2.backgroundColor = UIColor.greenColor() }
//Wednesday
        self.wed0 = tempUserSitterSchedIdentifier[step]["wed0"] as! Int
        self.wed1 = tempUserSitterSchedIdentifier[step]["wed1"] as! Int
        self.wed2 = tempUserSitterSchedIdentifier[step]["wed2"] as! Int
        
        if self.wed0 == 1 { self.WED_0.backgroundColor = UIColor.blueColor() } else { self.WED_0.backgroundColor = UIColor.greenColor() }
        if self.wed1 == 1 { self.WED_1.backgroundColor = UIColor.blueColor() } else { self.WED_1.backgroundColor = UIColor.greenColor() }
        if self.wed2 == 1 { self.WED_2.backgroundColor = UIColor.blueColor() } else { self.WED_2.backgroundColor = UIColor.greenColor() }
    }
// __________________________________ END ViewDidLoad ____________________________//
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
        
        flipView.font = "HelveticaNeue-Bold"
        flipView.fontSize = 36.0
        flipView.fontAlignment = "right" // not working yet... maybe when words wrap?
        flipView.textOffset = CGPointMake(125.0, 330.0);
//BASE LAYER
        if baseLayer == false {
            flipView.printText("End of Results", usingImage: nil, backgroundColor: UIColor.lightGrayColor(), textColor: UIColor.blueColor())
            tempUserCnxScoreIdentifier.append(0)
            tempUserSitterSchedIdentifier.append([ "fri0" : 1,"fri1": 0,"fri2":0,"mon0":0,"mon1":1,"mon2":0,"sat0":0,"sat1":0,"sat2":0,"sun0":1,"sun1":0,"sun2":0,"thu0":0,"thu1":1,"thu2":0,"tue0":0,"tue1":1,"tue2":1,"wed0":0,"wed1":0,"wed2":0])
            tempUserNameIdentifier.append("BASE-LAYER")
            baseLayer = true
            self.view.addSubview(flipView)
            print("do I need a baseLayer???")
            step = tempUserNameIdentifier.count - 1
            animationDelegate.startAnimation(kDirectionNone)
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
    @IBAction func tappedFlipThruSitters(sender: AnyObject) {
        self.loadAnimationVcElements()
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

    func loadAnimationVcElements () {
        

            self.flipThruBtn.removeFromSuperview()
            self.coverLabel.removeFromSuperview()
            
            self.view.addSubview(flipView)
            self.view.bringSubviewToFront(schedulizerLabel)
            self.view.bringSubviewToFront(nameLabel)
            self.bringScheduleSquaresToFront()
            self.nameLabel.text = "Social Context"
            print(step)
            print("checkpoint-01")
            print(tempUserNameIdentifier)
        if sitterFlipBookHasBeenLoaded == false {
            step = tempUserNameIdentifier.count - 1
            sitterFlipBookHasBeenLoaded = true
        }
            self.displayTargetSitterSchedule()

        
        self.timeSlotLabelsOnViewArray = [FRI_0, FRI_1,FRI_2,MON_0,MON_1,MON_2,SAT_0,SAT_1,SAT_2,SUN_0,SUN_1,SUN_2,THU_0,THU_1,THU_2,TUE_0,TUE_1,TUE_2,WED_0,WED_1,WED_2]
        tempTimeSlotArrFromAPI = [fri0,fri1,fri2,mon0,mon1,mon2,sat0,sat1,sat2,sun0,sun1,sun2,thu0,thu1,thu2,tue0,tue1,tue2,wed0,wed1,wed2]
        
        for (index, element) in self.timeSlotLabelsOnViewArray.enumerate()
        {
            self.dictionary[element] = tempTimeSlotArrFromAPI[index]
        }
        //========================================================================================================================//
//        print(self.dictionary)
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
        //========================= PAN-GESTURE ===============================//
        self.bringScheduleSquaresToFront()
    }

//[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[MAIN BUTTON]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]//


//[[[[[[[[[[[[[[[[[[[[[[[  END -- MAIN BUTTON  ]]]]]]]]]]]]]]]]]]]]]]]//
    var timeSlotIndex:Int = 0
//===========================> (SWIPE - HANDLER) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    func handleSwipe(recognizer:UISwipeGestureRecognizer){


//  Flick-UP => FORWARD
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Up) {
//            animationDelegate.startAnimation(kDirectionBackward)
            print("on UP Swipe!")
            
            if step < (tempUserNameIdentifier.count - 1) {
                animationDelegate.startAnimation(kDirectionBackward)
                print("SitterList Endpoint on UP Swipe")
                step += 1
            } else {
//                step = 1
                print("end of sitters -- on Swipe Up")
            }
        }
//  Flick-DOWN => BACKWARD
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Down) {
//                animationDelegate.startAnimation(kDirectionForward)
            //on the right track here, just need
            //some additional stoppage for schedulizer
            print("on down swipe")
            if step > 0 {
                animationDelegate.startAnimation(kDirectionForward)
                step -= 1
            } else {
//                animationDelegate.startAnimation(kDirectionNone)
                print("SitterList EndPoint on down swipe")
            }

        }
        
        self.view.bringSubviewToFront(NavBar);self.view.bringSubviewToFront(TopNavBar);self.view.bringSubviewToFront(schedulizerLabel);self.view.bringSubviewToFront(nameLabel)
//        if step == 0 {
//            self.view.bringSubviewToFront(nameLabel)
//            self.view.bringSubviewToFront(schedulizerLabel)
//        } else {
//            self.bringScheduleSquaresToFront()
//            self.displayTargetSitterSchedule()
//        }
        
        
        self.bringScheduleSquaresToFront()
        self.displayTargetSitterSchedule()
        

    }
    // ---------- END HandleSwipe func ---------------//
//===========================> (thru Sitter Array) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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
