
import UIKit
var step = Int()

var flipView = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(-100,100,575,500))
class AnimationViewController: UIViewController {
    
    var sitterObjArray = [SitterMatchModel]()
    var animationDelegate:AnimationDelegate = AnimationDelegate(sequenceType: kSequenceControlled, directionType: kDirectionNone)
    
    @IBOutlet weak var schedulizerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var TopNavBar: UINavigationBar!
    @IBOutlet weak var NavBar: UINavigationBar!
//    @IBOutlet weak var profileNameGradientBG: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("on view did load")
//                flipView.center = self.view.center
        animationDelegate.startAnimation(kDirectionNone)
        self.view.bringSubviewToFront(NavBar)
        self.view.bringSubviewToFront(TopNavBar)
//        self.view.bringSubviewToFront(profileNameGradientBG)

        
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

        flipView.printText("BASE LAYER", usingImage: UIImage(named: "jessica"), backgroundColor: nil, textColor: UIColor.blueColor())


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
        self.schedulizerLabel.text = "Schedulizer"
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
//                    self.view.bringSubviewToFront(profileNameGradientBG)
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
//            self.view.bringSubviewToFront(profileNameGradientBG)
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
