
import UIKit
var step = Int()

//var image : UIImage = UIImage()
//var page4 = UIImage(named: "page4")

class AnimationViewController: UIViewController {
    
    var models = [SitterMatchModel]()
    
    var flipView = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(0,100,450,500))

    var animationDelegate:AnimationDelegate = AnimationDelegate(sequenceType: kSequenceControlled, directionType: kDirectionNone)
//    @IBOutlet weak var imageCover: UIImageView!
    //    var helloPage4 = UIImageView(image: page4)
    //     var helloZane = UIImage(named: "zane")
//    @IBOutlet weak var imageOnVC: UIImageView!
    //    var bgImage = UIImageView(image: image)
    //    var bgImage = bedford! as UIImage
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var TopNavBar: UINavigationBar!
    @IBOutlet weak var NavBar: UINavigationBar!

//    @IBOutlet weak var labelOnVC: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sitterModelObjects.count)
        print("on view did load")
//        print(self.models)
//        print(self.models.count)
        
        animationDelegate.startAnimation(kDirectionNone)

        self.view.bringSubviewToFront(NavBar)
        self.view.bringSubviewToFront(self.TopNavBar)
//       labelOnVC.hidden = true
//        flipView.center = self.view.center
//        let helloPage4 = UIImageView(image: page4)
        animationDelegate.transformView = flipView
        animationDelegate.controller = self
        animationDelegate.perspectiveDepth = 75000
        animationDelegate.nextDuration = 0.18   //0.75
        animationDelegate.shadow = true
        animationDelegate.sensitivity = 8000
        animationDelegate.gravity = 32

        flipView.font = "HelveticaNeue-Bold"
        flipView.fontSize = 24.0
        flipView.fontAlignment = "right" // not working yet... maybe when words wrap?
        flipView.textOffset = CGPointMake(75.0, 75.0);

        flipView.printText("Hello-ANIMATE!", usingImage: UIImage(named: "zane"), backgroundColor: nil, textColor: UIColor.blueColor())
        flipView.printText("Hello-REVERSE", usingImage:  UIImage(named: "jessica"), backgroundColor: nil, textColor: UIColor.blueColor())
        flipView.printText("!!START-HERE!!", usingImage: UIImage(named: "me"), backgroundColor: nil, textColor: UIColor.blueColor())
//        flipView.printText("BEDFORD", usingImage: self.bgImage, backgroundColor: nil, textColor: UIColor.blueColor())
//        flipView.printText("Hello Zane", usingImage: self.helloZane!, backgroundColor: nil, textColor: UIColor.blueColor())
        
//        self.view.bringSubviewToFront(flipView)
//        self.view.bringSubviewToFront(self.NavBar)
//        self.view.bringSubviewToFront(self.TopNavBar)
//        self.imageCover = UIImageView(image: page4)
//        self.view.bringSubviewToFront(imageCover!)
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
        

    } // ________________________ END ViewDidLoad ____________________________//
    
    func handleSwipe(recognizer:UISwipeGestureRecognizer){
//Scroll Thru Sitters
        
//===========================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//  Flick-Up => FORWARD
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Up) {
            animationDelegate.startAnimation(kDirectionBackward)
            self.view.addSubview(flipView)
//            self.view.bringSubviewToFront(NavBar)
//            self.view.bringSubviewToFront(self.TopNavBar)
            self.nameLabel.text = "Jon Harlan"
        }
        
        
//  Flick-Down => BACKWARD (thru Sitter Array)
        if (recognizer.direction == UISwipeGestureRecognizerDirection.Down) {

            animationDelegate.startAnimation(kDirectionForward)
//            self.view.sendSubviewToBack(imageOnVC)
            self.view.addSubview(flipView)


// THIS WORKS... sort of...
//            UIView.animateWithDuration(0.33, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
//                self.labelOnVC.alpha = 0.33
//                self.labelOnVC.hidden = false
//                }, completion: nil)
//            self.view.bringSubviewToFront(self.labelOnVC)
//            self.view.bringSubviewToFront(NavBar)
//            self.view.bringSubviewToFront(self.TopNavBar)
            print("on down swipe")
            print(sitterModelObjects)
        }
    }
    // ---------- END HandleSwipe func ---------------//
    
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
