//
//  AnimationViewController.swift
//  FlipDraft02
//
//  Created by Jon Harlan on 1/8/16.
//  Copyright © 2016 Jon Harlan. All rights reserved.
//

import UIKit

var animationDelegate:AnimationDelegate = AnimationDelegate(sequenceType: kSequenceAuto, directionType: kDirectionForward)


class AnimationViewController: UIViewController {

    var flipView = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(60,95,200,50))
    var flipView2 = FlipView(animationType: kAnimationFlipVertical, frame: CGRectMake(60,95,200,50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flipView.printText("Hello FlipWorld", usingImage: nil, backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        flipView2.printText("flipview #2 !!!!", usingImage: nil, backgroundColor: UIColor.yellowColor(), textColor: UIColor.blackColor())
        
        // Do any additional setup after loading the view.
    }

    @IBAction func AnimateButton(sender: AnyObject) {
                animationDelegate.startAnimation(kDirectionForward)
                self.view.addSubview(flipView)
    }
    @IBAction func ReverseButton(sender: AnyObject) {
                animationDelegate.startAnimation(kDirectionForward)
                self.view.addSubview(flipView2)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
