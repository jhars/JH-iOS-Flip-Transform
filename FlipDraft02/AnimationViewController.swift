
import UIKit
var step = Int()

var flipView = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(0,100,450,500))
class AnimationViewController: UIViewController {
    
    var sitterObjArray = [SitterMatchModel]()
    var animationDelegate:AnimationDelegate = AnimationDelegate(sequenceType: kSequenceControlled, directionType: kDirectionNone)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var TopNavBar: UINavigationBar!
    @IBOutlet weak var NavBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sitterModelObjects.count)
        print("on view did load")
        //        flipView.center = self.view.center
        animationDelegate.startAnimation(kDirectionNone)
        self.view.bringSubviewToFront(NavBar)
        self.view.bringSubviewToFront(self.TopNavBar)
        animationDelegate.transformView = flipView
        animationDelegate.controller = self
        animationDelegate.perspectiveDepth = 75000
        animationDelegate.nextDuration = 0.44
        animationDelegate.shadow = true
        animationDelegate.sensitivity = 8000
        animationDelegate.gravity = 32

        flipView.font = "HelveticaNeue-Bold"
//        flipView.fontSize = 24
        flipView.fontAlignment = "right" // not working yet... maybe when words wrap?
        flipView.textOffset = CGPointMake(75.0, 75.0);

        flipView.printText("Hello-REVERSE", usingImage: nil, backgroundColor: UIColor.grayColor(), textColor: UIColor.blueColor())

        
          self.view.addSubview(flipView)
        
//========================= PAN-GESTURE ===============================//
//        self.panRegion = UIView(frame: self.view.frame)
//        view.addSubview(panRegion)
//        self.panned(panRecognizer)
//        self.panRecognizer.maximumNumberOfTouches = 1;
//        self.panRecognizer.minimumNumberOfTouches = 1;
        let showGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action: "handleSwipe:")
        showGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        flipView.addGestureRecognizer(showGestureRecognizer)
        
        let hideGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        hideGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        flipView.addGestureRecognizer(hideGestureRecognizer)
//========================= PAN-GESTURE ===============================//
//        self.sitterObjectLoader()
    } // ________________________ END ViewDidLoad ____________________________//    
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
//===========================> (thru Sitter Array) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    func handleSwipe(recognizer:UISwipeGestureRecognizer){
//  Flick-UP => FORWARD
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Up) {
            animationDelegate.startAnimation(kDirectionBackward)
            self.view.addSubview(flipView)
//            var sitterName = sitterModelObjects[0].name!
//            self.nameLabel.text = sitterName as String
        }
//  Flick-DOWN => BACKWARD
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Down) {

            animationDelegate.startAnimation(kDirectionForward)
            self.view.addSubview(flipView)
            print("on down swipe")
//            var sitterName = sitterModelObjects[1].name!
//            self.nameLabel.text = sitterName as String
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
