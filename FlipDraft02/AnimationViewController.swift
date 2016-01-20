
import UIKit
var step = Int()
var baseLayer:Bool = false

var weeklyTimeSlotArray = [UILabel]()


var flipView = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(-100,100,575,500))
class AnimationViewController: UIViewController {
    
    var sitterObjArray = [SitterMatchModel]()
    var animationDelegate:AnimationDelegate = AnimationDelegate(sequenceType: kSequenceControlled, directionType: kDirectionNone)
    
    @IBOutlet weak var schedulizerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var TopNavBar: UINavigationBar!
    @IBOutlet weak var NavBar: UINavigationBar!
    

    
    @IBOutlet weak var MON_0: UILabel!
    @IBOutlet weak var MON_1: UILabel!
    @IBOutlet weak var MON_2: UILabel!
    
    @IBOutlet weak var TUE_0: UILabel!
    @IBOutlet weak var TUE_1: UILabel!
    @IBOutlet weak var TUE_2: UILabel!
    
    @IBOutlet weak var WED_0: UILabel!
    @IBOutlet weak var WED_1: UILabel!
    @IBOutlet weak var WED_2: UILabel!
    
    @IBOutlet weak var THU_0: UILabel!
    @IBOutlet weak var THU_1: UILabel!
    @IBOutlet weak var THU_2: UILabel!
    
    @IBOutlet weak var FRI_0: UILabel!
    @IBOutlet weak var FRI_1: UILabel!
    @IBOutlet weak var FRI_2: UILabel!
    
    @IBOutlet weak var SAT_0: UILabel!
    @IBOutlet weak var SAT_1: UILabel!
    @IBOutlet weak var SAT_2: UILabel!
    
    @IBOutlet weak var SUN_0: UILabel!
    @IBOutlet weak var SUN_1: UILabel!
    @IBOutlet weak var SUN_2: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        flipView.removeFromSuperview()
        print("on view did load")

//                flipView.center = self.view.center
        animationDelegate.startAnimation(kDirectionNone)
        self.view.bringSubviewToFront(NavBar)
        self.view.bringSubviewToFront(TopNavBar)
        
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
            flipView.printText("BASE LAYER", usingImage: UIImage(named: "jessica"), backgroundColor: nil, textColor: UIColor.blueColor())
            baseLayer = true
        }
          self.view.addSubview(flipView)
        
//========================= PAN-GESTURE ===============================//
        let showGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action: "handleSwipe:")
        showGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        flipView.addGestureRecognizer(showGestureRecognizer)
        //        self.panRecognizer.maximumNumberOfTouches = 1;
        //        self.panRecognizer.minimumNumberOfTouches = 1;
        let hideGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        hideGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        flipView.addGestureRecognizer(hideGestureRecognizer)
//========================= PAN-GESTURE ===============================//
        self.view.bringSubviewToFront(schedulizerLabel)
        self.view.bringSubviewToFront(nameLabel)
        self.nameLabel.text = "Social Context"
        
        //========================================================================================================================//
        weeklyTimeSlotArray = [MON_0,MON_1,MON_2,TUE_0,TUE_1,TUE_2,WED_0,WED_1,WED_2,THU_0,THU_1,THU_2,FRI_0, FRI_1,FRI_2,SAT_0,SAT_1,SAT_2,SUN_0,SUN_1,SUN_2]
        
        print(sitterModelObjects)
        
        if mon0 == true {
            weeklyTimeSlotArray[0].backgroundColor = UIColor.blueColor()
        }
        //========================================================================================================================//
        
        for squares in weeklyTimeSlotArray {
            self.view.bringSubviewToFront(squares)
        }
        
    }
 // __________________________________ END ViewDidLoad ____________________________//
    
//===========================> (SWIPE - HANDLER) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    func handleSwipe(recognizer:UISwipeGestureRecognizer){
//  Flick-UP => FORWARD
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Up) {
            animationDelegate.startAnimation(kDirectionBackward)
            self.view.addSubview(flipView)
            print("on UP Swipe!")
//            self.nameLabel.text = "Wendy Darling"
            self.view.bringSubviewToFront(NavBar)
            self.view.bringSubviewToFront(TopNavBar)
            self.view.bringSubviewToFront(schedulizerLabel)
            self.view.bringSubviewToFront(nameLabel)
            for squares in weeklyTimeSlotArray {
                self.view.bringSubviewToFront(squares)
            }
        }
//  Flick-DOWN => BACKWARD
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Down) {
            animationDelegate.startAnimation(kDirectionForward)
            self.view.addSubview(flipView)
//            self.nameLabel.text = "Peter Pan"
            print("on down swipe")
            self.view.bringSubviewToFront(NavBar)
            self.view.bringSubviewToFront(TopNavBar)
            self.view.bringSubviewToFront(schedulizerLabel)
            self.view.bringSubviewToFront(nameLabel)
            for squares in weeklyTimeSlotArray {
                self.view.bringSubviewToFront(squares)
            }
        }
    }
    // ---------- END HandleSwipe func ---------------//
//===========================> (thru Sitter Array) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
// - - - - - - - - - - -  - - END PAN FUNCTION - - - - - - - - - - - - - - - - - - - - - - //

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
