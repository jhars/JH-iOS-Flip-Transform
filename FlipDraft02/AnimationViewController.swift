//
//  AnimationViewController.swift
//  FlipDraft02
//
//  Created by Jon Harlan on 1/8/16.
//  Copyright © 2016 Jon Harlan. All rights reserved.
//

import UIKit
var step = Int()
var flipView = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(0,0,450,600))
// frame:CGRectMake(60, 95, 200, 50)];
//var flipView = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(60, 95, 200, 400))


class AnimationViewController: UIViewController {

    //    var panRegion = UIView(frame: CGRectMake(60, 95, 200, 400))
    //    var panRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer()

    var animationDelegate:AnimationDelegate = AnimationDelegate(sequenceType: kSequenceTriggered, directionType: kDirectionForward)
    
    @IBOutlet weak var TopNavBar: UINavigationBar!
    @IBOutlet weak var NavBar: UINavigationBar!
    
    @IBOutlet weak var btmLeftProfileView: UIImageView!
    @IBOutlet weak var btmRightProfileView: UIImageView!
    @IBOutlet weak var topProfileImgView: UIImageView!
    @IBOutlet weak var bottomProfileImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flipView.center = self.view.center

        self.topProfileImgView.image = UIImage(named: "bedford")
        self.bottomProfileImgView.image = UIImage(named: "zane")


        animationDelegate.transformView = flipView
        animationDelegate.controller = self
        animationDelegate.perspectiveDepth = 15000

        flipView.font = "HelveticaNeue-Bold"
        flipView.fontSize = 24.0
        flipView.fontAlignment = "right" // not working yet... maybe when words wrap?
        flipView.textOffset = CGPointMake(75.0, 75.0);
//        flipView.textTruncationMode = kCATruncationEnd;

        flipView.printText("Hello-ANIMATE ", usingImage: UIImage(named: "zane"), backgroundColor: nil, textColor: UIColor.blueColor())
        flipView.printText("Hello-REVERSE", usingImage: nil, backgroundColor: UIColor.greenColor(), textColor: UIColor.yellowColor())
        flipView.printText("START-HERE", usingImage: nil, backgroundColor: UIColor.blueColor(), textColor: UIColor.whiteColor())
        self.view.addSubview(flipView)

        self.view.bringSubviewToFront(self.topProfileImgView)
        self.view.bringSubviewToFront(self.bottomProfileImgView)
        self.view.bringSubviewToFront(self.NavBar)
        self.view.bringSubviewToFront(self.TopNavBar)
        
        //========================= PAN-GESTURE ===============================//
//        self.panRegion = UIView(frame: self.view.frame)
//        view.addSubview(panRegion)
//        self.panned(panRecognizer)
//        self panRecognizer = UIPanGestureRecognizer(target: self, action: UIPanGestureRecognizer( -> Void in ))
//        self.panRecognizer.maximumNumberOfTouches = 1;
//        self.panRecognizer.minimumNumberOfTouches = 1;
//        self.view.addGestureRecognizer(self.panRecognizer)
        //========================= PAN-GESTURE ===============================//

    } // ________________________ END ViewDidLoad ____________________________//
    

    @IBAction func AnimateButton(sender: AnyObject) {

        animationDelegate.startAnimation(kDirectionForward)

        self.view.addSubview(flipView)
        
        self.view.bringSubviewToFront(NavBar)
        self.view.bringSubviewToFront(self.TopNavBar)
        
        self.view.bringSubviewToFront(self.topProfileImgView)
        self.topProfileImgView.image = UIImage(named: "me")
        self.view.bringSubviewToFront(self.bottomProfileImgView)
        self.bottomProfileImgView.image = UIImage(named: "jessica")
    }
    
    @IBAction func ReverseButton(sender: AnyObject) {
        animationDelegate.startAnimation(kDirectionBackward)

        self.view.addSubview(flipView)

        self.topProfileImgView.image = UIImage(named: "zane")
        self.view.bringSubviewToFront(self.topProfileImgView)

        self.view.bringSubviewToFront(NavBar)
        self.view.bringSubviewToFront(self.TopNavBar)
    }
    
    
// - - - - - - - - - - - - - -  - - (PETER) PAN FUNCTION - - - - - - - - - - - - - - - - - - - - - - //
    //    func panned(recognizer: UIPanGestureRecognizer) {
    //        switch recognizer.state {
    //
    //        case .Began:
    //            if CGRectContainsPoint(panRegion.frame, recognizer.locationInView(view!)) {
    //                print("began 02")
    //                if animationDelegate.animationState == 0 {
    //                    print("began 03")
    //                    NSObject.cancelPreviousPerformRequestsWithTarget(self)
    //                    animationDelegate.sequenceType = kSequenceControlled
    //                    animationDelegate.animationLock = true
    //                }
    //            }
    //        case .Cancelled:
    //            print("UIGestureRecognizer")
    //
    //        case .Ended:
    //            if animationDelegate.animationLock {
    //                print("animationLock")
    //                let value = sqrtf(fabsf(recognizer.velocityInView(self.view!).x as! Float) / 10.0)          //(fabsf(recognizer.velocityInView:self.view.x)) / 10.0.floatingPointClass
    //                self.animationDelegate.endStateWithSpeed(value)
    //            }
    //
    //        case .Possible:
    //            print("possible?")
    //
    //        case .Changed:
    //            if animationDelegate.animationLock {
    //                switch flipView.animationType {
    //                case kAnimationFlipHorizontal:
    //                    print("Horizontal")
    //                    var value = recognizer.translationInView(self.view!).x as! Float
    //                    animationDelegate.setTransformValue(value, delegating: false)
    //                case kAnimationFlipVertical:
    //                    print("vertical")
    //                    var value = recognizer.translationInView(self.view!).y as! Float
    //                    animationDelegate.setTransformValue(value, delegating: false)
    //                    break
    //                default:
    //                    print("began 0555")
    //                }
    //            }
    //
    //        case .Failed:
    //            print("failed :( ")
    //
    //        default:
    //            print("default")
    //        }
    //    }
// - - - - - - - - - - - - - -  - - END PAN FUNCTION - - - - - - - - - - - - - - - - - - - - - - //

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
