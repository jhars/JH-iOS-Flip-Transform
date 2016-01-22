// ************************************ //
// SitterBook Flip-Animation Controller //
// ************************************ //
import UIKit


var step = 0
var baseLayer = false
var tempSitterDisplayDictionary = [ : ]
var tempTimeSlotArrFromAPI = [Int]()

var flipView = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(-100,100,575,500))

class AnimationViewController: UIViewController {
    
    var sitterObjArray = [SitterMatchModel]()
    var animationDelegate:AnimationDelegate = AnimationDelegate(sequenceType: kSequenceControlled, directionType: kDirectionNone)
    var timeSlotLabelsOnViewArray = [UILabel]()
    //[[[[[[[[[[ CENTER-BUTTON ]]]]]]]]]]]\\
    @IBOutlet weak var flipThruBtn: UIButton!
    
// ================ SCHEDULIZER ================== //
//************************************************//
    @IBOutlet weak var schedulizerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var TopNavBar: UINavigationBar!
    @IBOutlet weak var NavBar: UINavigationBar!
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
//--------------- END SCHEDULIZER ----------------- //

    
    func displayTargetSitterSchedule () {
        print("update schedulizer here")
        //Friday
        self.fri0 = tempUserSitterSchedIdentifier[step]["fri0"] as! Int
        self.fri1 = tempUserSitterSchedIdentifier[step]["fri1"] as! Int
        self.fri2 = tempUserSitterSchedIdentifier[step]["fri2"] as! Int
        //Monday
        self.mon0 = tempUserSitterSchedIdentifier[step]["mon0"] as! Int
        self.mon1 = tempUserSitterSchedIdentifier[step]["mon1"] as! Int
        self.mon2 = tempUserSitterSchedIdentifier[step]["mon2"] as! Int
        //Saturday
        self.sat0 = tempUserSitterSchedIdentifier[step]["sat0"] as! Int
        self.sat1 = tempUserSitterSchedIdentifier[step]["sat1"] as! Int
        self.sat2 = tempUserSitterSchedIdentifier[step]["sat2"] as! Int
        //Sunday
        self.sun0 = tempUserSitterSchedIdentifier[step]["sun0"] as! Int
        self.sun1 = tempUserSitterSchedIdentifier[step]["sun1"] as! Int
        self.sun2 = tempUserSitterSchedIdentifier[step]["sun2"] as! Int
        //Thursday
        self.thu0 = tempUserSitterSchedIdentifier[step]["thu0"] as! Int
        self.thu1 = tempUserSitterSchedIdentifier[step]["thu1"] as! Int
        self.thu2 = tempUserSitterSchedIdentifier[step]["thu2"] as! Int
        //Tuesday
        self.tue0 = tempUserSitterSchedIdentifier[step]["tue0"] as! Int
        self.tue1 = tempUserSitterSchedIdentifier[step]["tue1"] as! Int
        self.tue2 = tempUserSitterSchedIdentifier[step]["tue2"] as! Int
        //Wednesday
        self.wed0 = tempUserSitterSchedIdentifier[step]["wed0"] as! Int
        self.wed1 = tempUserSitterSchedIdentifier[step]["wed1"] as! Int
        self.wed2 = tempUserSitterSchedIdentifier[step]["wed2"] as! Int
        
        if self.fri0 == 1 {
            self.FRI_0.backgroundColor = UIColor.blueColor()
        } else {
            self.FRI_0.backgroundColor = UIColor.greenColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        flipView.removeFromSuperview()
        print("on view did load")
        animationDelegate.transformView = flipView
        animationDelegate.controller = self
        animationDelegate.perspectiveDepth = 75000
        animationDelegate.nextDuration = 0.44
        animationDelegate.shadow = true
        animationDelegate.sensitivity = 8000
        animationDelegate.gravity = 32
        
        flipView.font = "HelveticaNeue-Bold"
        flipView.fontSize = 36.0
        flipView.fontAlignment = "right" // not working yet... maybe when words wrap?
        flipView.textOffset = CGPointMake(125.0, 330.0);
        
        if baseLayer == false {
            flipView.printText("BASE LAYER", usingImage: nil, backgroundColor: UIColor.lightGrayColor(), textColor: UIColor.blueColor())
            tempUserCnxScoreIdentifier.append(0)
            tempUserSitterSchedIdentifier.append([ "fri0" : 1,"fri1": 0,"fri2":0,"mon0":0,"mon1":0,"mon2":0,"sat0":0,"sat1":0,"sat2":0,"sun0":0,"sun1":0,"sun2":0,"thu0":0,"thu1":0,"thu2":0,"tue0":0,"tue1":0,"tue2":0,"wed0":0,"wed1":0,"wed2":0])
            tempUserNameIdentifier.append("BASE-LAYER")
            baseLayer = true
            self.view.bringSubviewToFront(flipView)
        } else {
            print("base layer loaded on initial ViewDidLoad")
        }
        self.view.sendSubviewToBack(flipView)
        self.view.bringSubviewToFront(flipThruBtn)
        
        //========================= PAN-GESTURE ===============================//
        let showGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action: "handleSwipe:")
        showGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        flipView.addGestureRecognizer(showGestureRecognizer)
        
        let hideGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        hideGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        flipView.addGestureRecognizer(hideGestureRecognizer)
        //========================= PAN-GESTURE ===============================//
        
    }
 // __________________________________ END ViewDidLoad ____________________________//
//[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[MAIN BUTTON]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]//
    @IBAction func tappedFlipThruSitters(sender: AnyObject) {
        //flipView.center = self.view.center
        animationDelegate.startAnimation(kDirectionNone)
        self.view.addSubview(flipView)
        self.view.bringSubviewToFront(NavBar)
        self.view.bringSubviewToFront(TopNavBar)
        self.flipThruBtn.removeFromSuperview()
        
        animationDelegate.transformView = flipView
        animationDelegate.controller = self
        animationDelegate.perspectiveDepth = 75000
        animationDelegate.nextDuration = 0.44
        animationDelegate.shadow = true
        animationDelegate.sensitivity = 8000
        animationDelegate.gravity = 32
        
        flipView.font = "HelveticaNeue-Bold"
        flipView.fontSize = 36.0
        flipView.fontAlignment = "right" // not working yet... maybe when words wrap?
        flipView.textOffset = CGPointMake(125.0, 330.0);
        

        self.view.sendSubviewToBack(flipView)
        self.view.bringSubviewToFront(schedulizerLabel)
        self.view.bringSubviewToFront(nameLabel)
        self.nameLabel.text = "Social Context"
        
        //========================================================================================================================//
        self.timeSlotLabelsOnViewArray = [FRI_0, FRI_1,FRI_2,MON_0,MON_1,MON_2,SAT_0,SAT_1,SAT_2,SUN_0,SUN_1,SUN_2,THU_0,THU_1,THU_2,TUE_0,TUE_1,TUE_2,WED_0,WED_1,WED_2]
        tempTimeSlotArrFromAPI = [fri0,fri1,fri2,mon0,mon1,mon2,sat0,sat1,sat2,sun0,sun1,sun2,thu0,thu1,thu2,tue0,tue1,tue2,wed0,wed1,wed2]
        //========================================================================================================================//
        print("checkpoint-01")
        for squares in self.timeSlotLabelsOnViewArray {
            self.view.bringSubviewToFront(squares)
        }
        print(tempUserNameIdentifier)
        step = tempUserNameIdentifier.count - 1
    }
//((((((((((((((((((((((((((((((((((((((MAIN BUTTON)))))))))))))))))))))))))))))//
    var timeSlotIndex:Int = 0
//===========================> (SWIPE - HANDLER) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    func handleSwipe(recognizer:UISwipeGestureRecognizer){


//  Flick-UP => FORWARD
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Up) {
            animationDelegate.startAnimation(kDirectionBackward)
            self.view.addSubview(flipView)
//            self.nameLabel.text = "Wendy Darling"
            print("on UP Swipe!")
            self.view.bringSubviewToFront(NavBar);self.view.bringSubviewToFront(TopNavBar);self.view.bringSubviewToFront(schedulizerLabel);self.view.bringSubviewToFront(nameLabel)

            if step < (tempUserNameIdentifier.count - 1) {
                print(tempUserNameIdentifier.count)
                print("No More Sitters")
                step += 1
            } else {
                step = 0
            }
            print(step);print(tempUserNameIdentifier[step]);print(tempUserCnxScoreIdentifier[step]);print(tempUserSitterSchedIdentifier[step])
            
            for squares in self.timeSlotLabelsOnViewArray {
                self.view.bringSubviewToFront(squares)
            }

            for timeSlot in tempUserSitterSchedIdentifier[step] {

                var Fri0 = tempUserSitterSchedIdentifier[step]["fri0"] as! Int
                print(Fri0)
                self.displayTargetSitterSchedule()
            }

        }
//  Flick-DOWN => BACKWARD
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Down) {
            animationDelegate.startAnimation(kDirectionForward)
            self.view.addSubview(flipView)
//            self.nameLabel.text = "Peter Pan"
            print("on down swipe")
            self.view.bringSubviewToFront(NavBar);self.view.bringSubviewToFront(TopNavBar);self.view.bringSubviewToFront(schedulizerLabel);self.view.bringSubviewToFront(nameLabel)
            
            if step > 0 {
                step -= 1
            } else {
                step = tempUserNameIdentifier.count - 1
            }
            print(step);print(tempUserNameIdentifier[step]);print(tempUserCnxScoreIdentifier[step]);print(tempUserSitterSchedIdentifier[step])
            
            for squares in self.timeSlotLabelsOnViewArray {
                self.view.bringSubviewToFront(squares)
            }
            for timeSlot in tempUserSitterSchedIdentifier[step] {

                var Fri0 = tempUserSitterSchedIdentifier[step]["fri0"] as! Int
                print(Fri0)
                self.displayTargetSitterSchedule()
            }
        }
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
