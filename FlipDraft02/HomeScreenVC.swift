//
//  HomeScreenVC.swift
//  FlipDraft02
//
//  Created by Jon Harlan on 1/9/16.
//  Copyright © 2016 Jon Harlan. All rights reserved.
//

import UIKit

var sitterFlipBookHasBeenLoaded = false

class HomeScreenVC: UIViewController {

    @IBAction func searchButton(sender: AnyObject) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if sitterFlipBookHasBeenLoaded == false {
            
            let targetVC:SitterMatchVC = storyboard.instantiateViewControllerWithIdentifier("SitterMatchView") as! SitterMatchVC
            self.presentViewController(targetVC, animated: true, completion: nil)
            sitterFlipBookHasBeenLoaded = true
            
        } else {
            
            let targetVC:AnimationViewController = storyboard.instantiateViewControllerWithIdentifier("AnimationView") as! AnimationViewController
            self.presentViewController(targetVC, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(flipView)
//        flipView.removeFromSuperview()
//        print("removed all flipViews")
//        sitterModelObjects.removeAll()
//        print(sitterModelObjects)
//        print("sitterModelObjects Removed")
//        tempUserSitterSchedIdentifier.removeAll()
//        print(tempSitterDisplayDictionary)
//        print(sitterFlipBookHasBeenLoaded)

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
