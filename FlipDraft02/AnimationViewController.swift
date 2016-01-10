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
class AnimationViewController: UIViewController {


    var animationDelegate:AnimationDelegate = AnimationDelegate(sequenceType: kSequenceTriggered, directionType: kDirectionForward)
//    var animationDelegate2:AnimationDelegate = AnimationDelegate(sequenceType: kSequenceTriggered, directionType: kDirectionNone)

    
    @IBOutlet weak var TopNavBar: UINavigationBar!
    @IBOutlet weak var NavBar: UINavigationBar!
    
    
    @IBOutlet weak var btmLeftProfileView: UIImageView!
    
    @IBOutlet weak var btmRightProfileView: UIImageView!
    
    @IBOutlet weak var topProfileImgView: UIImageView!
    @IBOutlet weak var bottomProfileImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var loginView = flipView
        self.topProfileImgView.image = UIImage(named: "bedford")
        self.bottomProfileImgView.image = UIImage(named: "zane")
        flipView.center = self.view.center
//        flipView.
//        let X_Co = ((self.view.frame.size.width - flipView.frame.width)/2)
//        print(X_Co)
//        let Y_Co = ((self.view.frame.size.height - flipView.frame.height)/2)
//        print(Y_Co)
//        flipView.frame = CGRectMake(X_Co, Y_Co - 35, self.view.frame.size.width, 600)
        
        
        animationDelegate.transformView = flipView
        animationDelegate.controller = self
        animationDelegate.perspectiveDepth = 15000
        //        self.view.addSubview(flipView)
        flipView.font = "HelveticaNeue-Bold"
        flipView.fontSize = 24.0
        flipView.fontAlignment = "right" // not working yet... maybe when words wrap?
        flipView.textOffset = CGPointMake(75.0, 75.0);
//        flipView.textTruncationMode = kCATruncationEnd;


        flipView.printText("Hello-ANIMATE ", usingImage: UIImage(named: "zane"), backgroundColor: nil, textColor: UIColor.blueColor())
        flipView.printText("Hello-REVERSE", usingImage: nil, backgroundColor: UIColor.greenColor(), textColor: UIColor.yellowColor())
        flipView.printText("START-HERE", usingImage: nil, backgroundColor: UIColor.blueColor(), textColor: UIColor.whiteColor())
        //        animationDelegate.startAnimation(kDirectionForward)
        self.view.addSubview(flipView)

//        self.view.bringSubviewToFront(self.topProfileImgView)
        self.view.bringSubviewToFront(self.bottomProfileImgView)
        self.view.bringSubviewToFront(self.NavBar)
        self.view.bringSubviewToFront(self.TopNavBar)

//        flipView.sublayerCornerRadius = 6.0
//        var animationDelegate2:AnimationDelegate = AnimationDelegate(sequenceType: kSequenceAuto, directionType: kDirectionForward)
//        var flipView2 = FlipView(animationType: kAnimationFlipHorizontal, frame: CGRectMake(60, 240, 200, 110))
//        animationDelegate2.transformView = flipView2
//        animationDelegate2.controller = self
//        animationDelegate2.perspectiveDepth = 2000
//        flipView2.printText("flipview #2 !!!!", usingImage: nil, backgroundColor: UIColor.yellowColor(), textColor: UIColor.blackColor())
    }

    @IBAction func AnimateButton(sender: AnyObject) {


        animationDelegate.startAnimation(kDirectionForward)


        self.view.addSubview(flipView)
        self.view.bringSubviewToFront(self.bottomProfileImgView)

        
        
        
        self.view.bringSubviewToFront(NavBar)
        self.view.bringSubviewToFront(self.TopNavBar)

        self.view.bringSubviewToFront(self.topProfileImgView)
//        animationDelegate.startAnimation(kDirectionForward)
    }
    
    @IBAction func ReverseButton(sender: AnyObject) {
        animationDelegate.startAnimation(kDirectionBackward)


        self.view.addSubview(flipView)

        self.topProfileImgView.image = UIImage(named: "zane")
        self.view.bringSubviewToFront(self.topProfileImgView)

        
        
        self.view.bringSubviewToFront(NavBar)
        self.view.bringSubviewToFront(self.TopNavBar)
        
//        self.view.addSubview(self.bottomProfileImgView)
        

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
